# Instruções de Operação - Desafio DevOps 2025

Este documento oferece instruções para instalar, configurar e operar a solução desenvolvida para o Desafio DevOps 2025.

## Requisitos do Sistema

Para executar este projeto, precisará ter instalado:

- **Docker Desktop** (Windows/Mac) ou Docker Engine + Docker Compose (Linux)
- **Git** (para clonar o repositório)

## Arquitetura da Solução

A solução consiste em:

1. **Duas aplicações em linguagens diferentes**:
   - App1: Python com Flask
   - App2: Node.js com Express
   - Ambas com rotas para texto fixo (`/hello`) e horário atual (`/time`)

2. **Camada de cache**:
   - Nginx configurado com diferentes TTLs:
     - 10 segundos para App1
     - 60 segundos para App2

3. **Monitoramento**:
   - Prometheus para coleta de métricas
   - Grafana para visualização

## Instalação e Execução

### Passo 1: Clonar o Repositório

```bash
git clone https://github.com/[seu-usuario]/desafio-devops-2025.git
cd desafio-devops-2025
```

### Passo 2: Iniciar a Infraestrutura

Método simples (recomendado):
```bash
# Tornar o script executável
chmod +x setup.sh

# Executar o script de setup
./setup.sh
```

Alternativamente, usando comandos Docker diretamente:
```bash
# Iniciar todos os serviços
docker compose up -d
```

### Passo 3: Verificar o Status

Após a inicialização (que pode levar alguns segundos), você pode verificar se tudo está funcionando corretamente:

```bash
# Verificar os containers em execução
docker ps

# Ou executar o script de teste
chmod +x test.sh
./test.sh
```

## Acessando as Aplicações e Serviços

Uma vez que a infraestrutura esteja em execução, acessar:

### Aplicações

- **App1 (Python)**:
  - Texto fixo: http://localhost/app1/hello
  - Horário atual: http://localhost/app1/time

- **App2 (Node.js)**:
  - Texto fixo: http://localhost/app2/hello
  - Horário atual: http://localhost/app2/time

### Monitoramento

- **Prometheus**: http://localhost:9090
- **Grafana**: http://localhost:3001
  - Usuário: admin
  - Senha: admin

## Testando o Mecanismo de Cache

O cache está configurado com diferentes tempos de expiração:
- App1: 10 segundos
- App2: 60 segundos

Para verificar o funcionamento do cache:

1. Acessar uma das rotas (ex: http://localhost/app1/hello)
2. Observar o cabeçalho `X-Cache-Status` na resposta (usando as ferramentas de desenvolvedor do navegador ou curl)
3. Atualizar a página imediatamente - você verá `X-Cache-Status: HIT` indicando que a resposta veio do cache
4. Aguardar o tempo de expiração (10s para App1 ou 60s para App2)
5. Atualizar novamente - você verá `X-Cache-Status: MISS` indicando que o cache expirou

Também pode usar o script de teste que verifica automaticamente este comportamento:
```bash
./test.sh
```

## Monitoramento com Grafana

Para configurar e utilizar o Grafana:

1. Acessar http://localhost:3001 (credenciais: admin/admin)
2. Configure o Prometheus como fonte de dados:
   - Vá em Configuration > Data Sources > Add data source
   - Selecione Prometheus
   - URL: http://prometheus:9090
   - Clique em "Save & Test"

3. Criar um novo dashboard:
   - Clique em "+" > Dashboard
   - Adicione um novo painel
   - Configure uma consulta usando métricas como `app_requests_total` ou `nodejs_http_requests_total`

## Operações Comuns

### Verificar Logs

```bash
# Ver logs da aplicação Python
docker logs app1-python

# Ver logs da aplicação Node.js
docker logs app2-nodejs

# Ver logs do Nginx (cache)
docker logs nginx-cache
```

### Reiniciar Serviços

```bash
# Reiniciar todos os serviços
docker compose restart

# Reiniciar um serviço específico
docker compose restart app1
```

### Parar a Infraestrutura

```bash
# Parar todos os serviços
docker compose down

# Para remover também os volumes
docker compose down -v
```

## Resolução de Problemas

1. **Containers não iniciam**:
   - Verifique se as portas não estão em uso: `netstat -ano | findstr "80 3000 5000 9090 3001"`
   - Verifique os logs: `docker logs [nome-do-container]`

2. **Não consegue acessar as aplicações**:
   - Verifique se o Nginx está em execução: `docker ps | grep nginx`
   - Confira se o Docker Desktop está em execução

3. **Cache não funciona**:
   - Verifique os logs do Nginx: `docker logs nginx-cache`
   - Certifique-se de que o cabeçalho `X-Cache-Status` está presente nas respostas

## Conclusão

Esta solução implementa duas aplicações web com uma camada de cache e monitoramento, conforme solicitado no Desafio DevOps 2025. A infraestrutura é gerenciada por Docker Compose e pode ser facilmente iniciada com poucos comandos.

Se precisar de assistência adicional, entre em contato através do [flacks.cel@gmail.com].
