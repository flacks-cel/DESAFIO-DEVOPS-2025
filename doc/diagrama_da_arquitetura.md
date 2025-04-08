# Diagrama de Arquitetura - Desafio DevOps 2025

## Diagrama da Infraestrutura

```
                         ┌──────────────────────────────────────────────────────────────┐
                         │                                                              │
                         │                       Docker Compose                         │
                         │                                                              │
┌────────────────────────┼──────────────────────────────────────────────────────────────┼────────────────────────┐
│                        │                                                              │                        │
│                 ┌──────▼──────┐                                                       │                        │
│                 │             │                                                       │                        │
│    ┌────────────►   Cliente   ├────────────┐                                          │                        │
│    │            │             │            │                                          │                        │
│    │            └─────────────┘            │                                          │                        │
│    │                                       │                                          │                        │
│    │                                       ▼                                          │                        │
│    │                                ┌────────────┐                                    │                        │
│    │                                │            │   ┌───────────────┐                │                        │
│    │                                │            ├───►  Cache App1   │ TTL: 10s       │                        │
│    │                                │   NGINX    │   │ (10 segundos) │                │                        │
│    │                                │  (Porta 80)├───┤               │                │                        │
│    │                                │            │   └───────────────┘                │                        │
│    │                                │   Cache    │                                    │                        │
│    │                                │   Layer    │   ┌───────────────┐                │                        │
│    │                                │            ├───►  Cache App2   │ TTL: 60s       │                        │
│    │                                │            │   │ (60 segundos) │                │                        │
│    │                                └─┬───┬───┬──┘   └───────────────┘                │                        │
│    │                                  │   │   │                                       │                        │
│    │                            ┌─────┘   │   └────────┐                             │                        │
│    │                            │         │            │                             │                        │
│    │                            ▼         │            ▼                             │                        │
│    │                     ┌────────────┐   │     ┌────────────┐                       │                        │
│    │                     │            │   │     │            │                       │                        │
│    │                     │  App1      │   │     │   App2     │                       │                        │
│    │                     │  Python    │   │     │   Node.js  │                       │                        │
│    │                     │  (Flask)   │   │     │  (Express) │                       │                        │
│    │                     │Porta: 5000 │   │     │Porta: 3000 │                       │                        │
│    │                     │            │   │     │            │                       │                        │
│    │                     │ /hello     │   │     │ /hello     │                       │                        │
│    │                     │ /time      │   │     │ /time      │                       │                        │
│    │                     │            │   │     │            │                       │                        │
│    │                     └──────┬─────┘   │     └──────┬─────┘                       │                        │
│    │                            │         │            │                             │                        │
│    │                            │         │            │                             │                        │
│    │                            └────┐    │    ┌───────┘                             │                        │
│    │                                 │    │    │                                     │                        │
│    │                                 ▼    ▼    ▼                                     │                        │
│    │                          ┌──────────────────────┐                               │                        │
│    │                          │                      │                               │                        │
│    │                          │     Prometheus       │                               │                        │
│    │                          │    (Porta: 9090)     │                               │                        │
│    │                          │                      │                               │                        │
│    │                          └──────────┬───────────┘                               │                        │
│    │                                     │                                           │                        │
│    │                                     ▼                                           │                        │
│    │                          ┌──────────────────────┐                               │                        │
│    │                          │                      │                               │                        │
│    └──────────────────────────┤       Grafana        │                               │                        │
│                               │     (Porta: 3001)    │                               │                        │
│                               │                      │                               │                        │
│                               └──────────────────────┘                               │                        │
│                                                                                      │                        │
└──────────────────────────────────────────────────────────────────────────────────────┴────────────────────────┘
```

## Fluxo de Requisições

1. O cliente acessa as aplicações através do NGINX (http://localhost/app1/hello ou http://localhost/app2/hello)
2. O NGINX verifica se a resposta está em cache:
   - Se estiver em cache e não expirado, retorna diretamente (CACHE HIT)
   - Se não estiver em cache ou expirado, encaminha para a aplicação apropriada (CACHE MISS)
3. A aplicação processa a requisição e retorna o resultado
4. O NGINX armazena a resposta em cache pelo tempo configurado (10s para App1, 60s para App2)
5. A resposta é enviada ao cliente com o cabeçalho X-Cache-Status indicando o status do cache

## Fluxo de Métricas

1. As aplicações expõem métricas no endpoint /metrics
2. O Prometheus coleta periodicamente as métricas de todas as aplicações
3. O Grafana consulta o Prometheus para visualizar as métricas em dashboards

## Componentes do Sistema

| Componente | Tecnologia | Função | Porta |
|------------|------------|--------|-------|
| App1 | Python/Flask | API com rotas /hello e /time | 5000 |
| App2 | Node.js/Express | API com rotas /hello e /time | 3000 |
| NGINX | Nginx | Proxy reverso e camada de cache | 80 |
| Prometheus | Prometheus | Coleta e armazenamento de métricas | 9090 |
| Grafana | Grafana | Visualização de métricas e dashboards | 3001 |

## Volumes Persistentes

- **nginx-cache**: Armazena os dados de cache
- **prometheus-data**: Armazena as métricas coletadas
- **grafana-data**: Armazena configurações e dashboards do Grafana