# Desafio DevOps 2025

Este projeto implementa uma infraestrutura completa com duas aplicações em linguagens diferentes (Python e Node.js), uma camada de cache com diferentes tempos de expiração e monitoramento integrado.

## Arquitetura da Solução

A arquitetura proposta consiste em:

1. **Duas aplicações**:
   - **App1 (Python/Flask)**: Aplicação simples com 2 endpoints (`/hello` e `/time`) e cache de 10 segundos
   - **App2 (Node.js/Express)**: Aplicação similar com os mesmos endpoints e cache de 1 minuto

2. **Camada de cache**:
   - **Nginx**: Serve como proxy reverso e implementa a camada de cache com diferentes tempos de expiração

3. **Observabilidade**:
   - **Prometheus**: Coleta métricas de todas as aplicações
   - **Grafana**: Visualização de dashboards para monitoramento

4. **Infraestrutura**:
   - **Docker**: Containerização de todos os componentes
   - **Docker Compose**: Orquestração dos containers

## Requisitos

- Docker
- Docker Compose
- Git

## Instalação e Execução

A infraestrutura foi projetada para ser iniciada com o menor número possível de comandos:

```bash
# Clone o repositório
git clone https://github.com/seu-usuario/desafio-devops-2025.git
cd desafio-devops-2025

# Execute o script de configuração e inicialização
chmod +x setup.sh
./setup.sh