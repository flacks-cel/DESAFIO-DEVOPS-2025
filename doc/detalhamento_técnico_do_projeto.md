# Detalhamento Técnico do Projeto

## Análise da Implementação do Cache com Nginx

A camada de cache implementada neste projeto utiliza o Nginx como proxy reverso e sistema de caching. A seguir, detalho os principais aspectos técnicos da implementação:

### Configuração das Zonas de Cache

```nginx
# Configuração da zona de cache
proxy_cache_path /var/cache/nginx/app1_cache levels=1:2 keys_zone=app1_cache:10m max_size=100m inactive=10s;
proxy_cache_path /var/cache/nginx/app2_cache levels=1:2 keys_zone=app2_cache:10m max_size=100m inactive=60s;
```

Nesta configuração:
- **Caminhos distintos**: Separei fisicamente o cache de cada aplicação
- **Estrutura de níveis (levels=1:2)**: Otimiza a organização de arquivos no filesystem
- **Tamanho das zonas de memória (keys_zone=10m)**: Aloquei 10MB para índices de cache
- **Limite de tamanho (max_size=100m)**: Evita crescimento descontrolado
- **Tempo de inatividade (inactive)**: Configurado de acordo com o TTL de cada aplicação

### Configuração por Localização

```nginx
# Roteamento para App 1 (Python) - Cache de 10 segundos
location /app1/ {
    proxy_pass http://app1:5000/;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    
    # Configuração de cache
    proxy_cache app1_cache;
    proxy_cache_valid 200 10s;
    proxy_cache_use_stale error timeout updating http_500 http_502 http_503 http_504;
    
    # Adiciona cabeçalho para identificar hits/misses no cache
    add_header X-Cache-Status $upstream_cache_status;
}
```

Aspectos importantes:
- **Proxy transparente**: Encaminha requisições preservando headers importantes
- **Cache condicional (proxy_cache_valid)**: Cache apenas para respostas 200 OK
- **Estratégia para falhas (proxy_cache_use_stale)**: Serve conteúdo desatualizado em caso de falhas
- **Transparência (X-Cache-Status)**: Facilita debug e monitoramento

### Considerações de Design

1. **Separação de caches**: Cada aplicação tem seu próprio cache, evitando interferências
2. **TTLs diferentes**: Implementamos precisamente os requisitos (10s e 60s)
3. **Resiliência**: O uso de `proxy_cache_use_stale` aumenta a disponibilidade mesmo quando backends falham
4. **Monitorabilidade**: Headers e logs formatados para facilitar análise

## Implementação de Observabilidade

### Instrumentação das Aplicações

#### Python/Flask
```python
from prometheus_client import Counter, Histogram, generate_latest

# Métricas
REQUEST_COUNT = Counter('app_requests_total', 'Total app HTTP requests', ['method', 'endpoint', 'status'])
REQUEST_LATENCY = Histogram('app_request_latency_seconds', 'Request latency in seconds', ['method', 'endpoint'])

@app.route('/metrics')
def metrics():
    return generate_latest(), 200, {'Content-Type': CONTENT_TYPE_LATEST}
```

#### Node.js/Express
```javascript
const promClient = require('prom-client');
const register = new promClient.Registry();

// Métricas personalizadas
const httpRequestCounter = new promClient.Counter({
  name: 'nodejs_http_requests_total',
  help: 'Total de requisições HTTP',
  labelNames: ['method', 'endpoint', 'status'],
  registers: [register]
});
```

### Coleta e Visualização

1. **Prometheus**: Configurado para scrape periódico de todas as aplicações
2. **Grafana**: Integrado para visualização em dashboards
3. **Métricas padronizadas**: Nomenclatura consistente entre aplicações
4. **Granularidade**: Métricas por endpoint e método HTTP

### Logs Estruturados

Ambas as aplicações utilizam logging estruturado (JSON) para facilitar a análise:

```javascript
// Node.js
const logger = winston.createLogger({
  format: winston.format.combine(
    winston.format.timestamp(),
    winston.format.json()
  )
});
```

```python
# Python
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(name)s - %(levelname)s - %(message)s')
```

## Estratégia de Atualização de Componentes

### Aplicações

Para atualizar as aplicações sem downtime significativo, implementamos uma estratégia baseada em containers:

1. **Build de nova imagem**: `docker-compose build app1`
2. **Deploy controlado**: `docker-compose up -d app1`
3. **Verificação de saúde**: Health checks garantem que apenas instâncias saudáveis recebam tráfego

### Configuração de Cache

O Nginx permite recarregar sua configuração sem interromper o serviço:

```bash
docker-compose exec nginx nginx -s reload
```

Esta operação mantém as conexões existentes e aplica a nova configuração apenas às novas requisições.

### Monitoramento

A atualização do Prometheus e Grafana pode ser feita com mínimo impacto:

1. **Prometheus**: Suporta recarregamento de configuração via API ou sinal
2. **Grafana**: Atualizações de dashboard não afetam o serviço

## Detalhes de Implementação das Aplicações

### App1 (Python/Flask)

```python
@app.route('/hello')
def hello():
    start_time = time.time()
    logger.info("Recebida requisição em /hello")
    
    response = jsonify({"message": "Olá do Serviço Python!"})
    
    # Métricas
    REQUEST_COUNT.labels('GET', '/hello', '200').inc()
    REQUEST_LATENCY.labels('GET', '/hello').observe(time.time() - start_time)
    
    return response
```

Esta implementação:
1. Registra o início da requisição
2. Responde com um JSON fixo
3. Incrementa contadores de métricas
4. Registra a latência da operação

### App2 (Node.js/Express)

```javascript
app.get('/time', (req, res) => {
  const end = httpRequestDuration.startTimer({ method: 'GET', endpoint: '/time' });
  logger.info('Recebida requisição em /time');
  
  const now = new Date();
  const formattedTime = now.toISOString().replace('T', ' ').substring(0, 19);
  res.json({ current_time: formattedTime });
  
  httpRequestCounter.inc({ method: 'GET', endpoint: '/time', status: 200 });
  end();
});
```

Esta implementação:
1. Inicia um timer para medir latência
2. Registra a requisição via log estruturado
3. Retorna o horário atual formatado
4. Registra métricas usando o cliente Prometheus

## Infraestrutura como Código (IaC)

Todo o ambiente é definido como código usando Docker Compose:

```yaml
version: '3.8'

services:
  app1:
    build:
      context: ./app1-python
    container_name: app1-python
    # ...configurações
    
  app2:
    build:
      context: ./app2-nodejs
    # ...configurações
    
  nginx:
    build:
      context: ./nginx
    # ...configurações
    
  prometheus:
    image: prom/prometheus:v2.30.0
    # ...configurações
    
  grafana:
    image: grafana/grafana:8.2.0
    # ...configurações
```

Benefícios desta abordagem:
1. **Reprodutibilidade**: Ambiente idêntico em qualquer host
2. **Versionamento**: A configuração é versionada junto com o código
3. **Documentação viva**: O arquivo descreve toda a arquitetura
4. **Facilidade de execução**: Apenas um comando para iniciar tudo

## Considerações de Segurança

Alguns aspectos de segurança implementados:

1. **Isolamento de rede**: Uso de rede bridge dedicada
2. **Exposição mínima de portas**: Apenas o necessário é exposto
3. **Controle de recursos**: Logging configurado com rotação para evitar esgotamento de disco
4. **Imagens base seguras**: Uso de versões específicas e imagens Alpine

Pontos para evolução:
1. Implementação de HTTPS
2. Autenticação para endpoints sensíveis
3. Network policies mais restritivasss

## Conclusão

A implementação atual atende aos requisitos do desafio com uma abordagem moderna e baseada em boas práticas DevOps. O foco principal foi em criar uma solução que demonstre os conceitos solicitados (aplicações em diferentes linguagens, cache com TTLs diferentes, facilidade de execução e observabilidade) de forma estruturada e bem documentada.

A arquitetura é modular e extensível, permitindo evoluções futuras conforme detalhado no documento de pontos de melhoria.