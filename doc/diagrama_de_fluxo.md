# Fluxo de Atualização dos Componentes

Este documento descreve os processos de atualização para cada componente da infraestrutura implementada para o Desafio DevOps 2025.

## Diagrama de Fluxo de Atualização

```
┌───────────────────────────────────────────────────────────────────────────────────────────┐
│                                                                                           │
│                              FLUXO DE ATUALIZAÇÃO DE COMPONENTES                          │
│                                                                                           │
└───────────────────────────────────────────────────────────────────────────────────────────┘
   │
   │
   ▼
┌───────────────────────────────────────────────────────────────────────────────────────────┐
│                                                                                           │
│                      REPOSITÓRIO GIT (CONTROLE DE VERSÃO DO CÓDIGO)                       │
│                                                                                           │
└───────────────────────────────────────────────────────────────────────────────────────────┘
   │
   │  git pull
   ▼
┌───────────────────────────────────────┬───────────────────────────┬───────────────────────┐
│                                       │                           │                       │
│  ATUALIZAÇÃO DE APLICAÇÕES            │  ATUALIZAÇÃO DO NGINX     │  ATUALIZAÇÃO DO       │
│  (APP1 - PYTHON, APP2 - NODE.JS)      │  (CONFIGURAÇÃO DE CACHE)  │  MONITORAMENTO        │
│                                       │                           │                       │
└───────────────────┬───────────────────┴─────────────┬─────────────┴──────────┬────────────┘
                    │                                 │                        │
                    ▼                                 ▼                        ▼
┌───────────────────────────────┐  ┌───────────────────────────────┐  ┌───────────────────────────────┐
│ 1. Modificar código-fonte     │  │ 1. Atualizar nginx.conf       │  │ 1. Atualizar configurações    │
│    - app.py (App1 - Python)   │  │    - Ajustar TTLs de cache    │  │    - prometheus.yml           │
│    - app.js (App2 - Node.js)  │  │    - Modificar configurações  │  │    - Dashboards do Grafana    │
└───────────────┬───────────────┘  └───────────────┬───────────────┘  └───────────────┬───────────────┘
                │                                  │                                  │
                ▼                                  ▼                                  ▼
┌───────────────────────────────┐  ┌───────────────────────────────┐  ┌───────────────────────────────┐
│ 2. Reconstruir imagem         │  │ 2. Reconstruir imagem         │  │ 2. Para Prometheus:           │
│    Docker da aplicação        │  │    Docker do Nginx            │  │    - Reiniciar serviço        │
│                               │  │                               │  │    Para Grafana:              │
│  docker compose build app1    │  │  docker compose build nginx   │  │    - Alterações via UI        │
│  ou                           │  │                               │  │    - Importe de dashboards    │
│  docker compose build app2    │  │                               │  │                               │
└───────────────┬───────────────┘  └───────────────┬───────────────┘  └───────────────┬───────────────┘
                │                                  │                                  │
                ▼                                  ▼                                  ▼
┌───────────────────────────────┐  ┌───────────────────────────────┐  ┌───────────────────────────────┐
│ 3. Atualizar container        │  │ 3. Opção 1: Atualizar         │  │ 3. Reiniciar serviços:        │
│    em execução                │  │    container (com downtime):  │  │                               │
│                               │  │                               │  │    Prometheus:                │
│  docker compose up -d app1    │  │  docker compose up -d nginx   │  │    docker compose restart     │
│  ou                           │  │                               │  │    prometheus                 │
│  docker compose up -d app2    │  │  Opção 2: Reload sem downtime:│  │                               │
│                               │  │  docker compose exec nginx    │  │    Grafana:                   │
│                               │  │  nginx -s reload              │  │    Não requer reinício para   │
│                               │  │                               │  │    mudanças na UI             │
└───────────────┬───────────────┘  └───────────────┬───────────────┘  └───────────────┬───────────────┘
                │                                  │                                  │
                ▼                                  ▼                                  ▼
┌───────────────────────────────┐  ┌───────────────────────────────┐  ┌───────────────────────────────┐
│ 4. Verificar logs e validar   │  │ 4. Verificar funcionamento:   │  │ 4. Validar atualizações:      │
│    funcionamento              │  │    - Teste de cache           │  │    - Verificar metrics em     │
│                               │  │    - Headers X-Cache-Status   │  │      /metrics                 │
│  docker logs app1-python      │  │                               │  │    - Testar alertas (se       │
│  ou                           │  │  ./test.sh                    │  │      configurados)            │
│  docker logs app2-nodejs      │  │                               │  │    - Verificar dashboards     │
└───────────────────────────────┘  └───────────────────────────────┘  └───────────────────────────────┘
```

## Processo Detalhado por Componente

### 1. Atualizando Aplicações

#### Para App1 (Python/Flask):

1. **Modificar código-fonte**:
   ```bash
   # Editar o arquivo app.py na pasta app1-python
   code app1-python/app.py
   ```

2. **Reconstruir a imagem Docker**:
   ```bash
   docker compose build app1
   ```

3. **Atualizar o container em execução**:
   ```bash
   docker compose up -d app1
   ```

4. **Verificar os logs**:
   ```bash
   docker logs app1-python
   ```

#### Para App2 (Node.js/Express):

1. **Modificar código-fonte**:
   ```bash
   # Editar o arquivo app.js na pasta app2-nodejs
   code app2-nodejs/app.js
   ```

2. **Reconstruir a imagem Docker**:
   ```bash
   docker compose build app2
   ```

3. **Atualizar o container em execução**:
   ```bash
   docker compose up -d app2
   ```

4. **Verificar os logs**:
   ```bash
   docker logs app2-nodejs
   ```

### 2. Atualizando a Configuração do Nginx (Cache)

1. **Modificar configuração**:
   ```bash
   # Editar o arquivo nginx.conf na pasta nginx
   code nginx/nginx.conf
   ```

2. **Reconstruir a imagem Docker**:
   ```bash
   docker compose build nginx
   ```

3. **Opção 1 - Atualizar o container (pode causar downtime breve)**:
   ```bash
   docker compose up -d nginx
   ```

   **Opção 2 - Recarregar configuração sem downtime**:
   ```bash
   docker compose exec nginx nginx -s reload
   ```

4. **Verificar funcionamento do cache**:
   ```bash
   # Executar script de teste para verificar cache
   ./test.sh
   
   # Ou verificar manualmente acessando a aplicação e observando os headers
   # Usar as ferramentas de desenvolvedor do navegador para ver o header X-Cache-Status
   ```

### 3. Atualizando Monitoramento

#### Para Prometheus:

1. **Modificar configuração**:
   ```bash
   # Editar o arquivo prometheus.yml na pasta prometheus
   code prometheus/prometheus.yml
   ```

2. **Reiniciar o serviço**:
   ```bash
   docker compose restart prometheus
   ```

3. **Verificar se as métricas estão sendo coletadas**:
   ```bash
   # Acessar a interface web do Prometheus
   http://localhost:9090
   ```

#### Para Grafana:

1. **Atualizar dashboards**:
   - Acesse a interface web do Grafana: http://localhost:3001
   - Faça login com usuário admin/admin
   - Navegue até Dashboards e faça as alterações necessárias
   - As alterações são salvas automaticamente no volume persistente

2. **Importar novos dashboards**:
   - Na interface do Grafana, vá para Dashboards -> Import
   - Importe um dashboard da comunidade ou um arquivo JSON personalizado

3. **Adicionar novas fontes de dados**:
   - Acesse Configuration -> Data Sources
   - Adicione ou edite fontes de dados conforme necessário

## Dicas e Melhores Práticas

1. **Testes antes da atualização**:
   - Teste suas alterações localmente antes de aplicá-las ao ambiente
   - Para aplicações, execute testes unitários quando disponíveis

2. **Backups**:
   - Faça backup dos volumes persistentes antes de atualizações importantes
   - Use `docker compose down` com cuidado, pois pode remover volumes se usado com `-v`

3. **Monitoramento durante atualizações**:
   - Observe os logs durante as atualizações para detectar problemas
   - Verifique se as métricas continuam sendo coletadas após as atualizações

4. **Estratégia de rollback**:
   - Mantenha versões anteriores das configurações
   - Para reverter mudanças em aplicações, reconstrua a imagem com a versão anterior

5. **Atualizações sem downtime**:
   - Para o Nginx, use `nginx -s reload` sempre que possível
   - Para aplicações críticas, considere implementar um padrão de implantação blue/green em projetos futuros