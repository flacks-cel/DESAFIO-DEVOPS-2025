#!/bin/bash
# Script para configurar e iniciar toda a infraestrutura

# Cores para output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Iniciando Desafio DevOps 2025 ===${NC}"

# Verificando dependências
echo -e "${GREEN}Verificando dependências...${NC}"
if ! command -v docker &> /dev/null; then
    echo -e "${RED}Docker não encontrado. Por favor, instale o Docker antes de continuar.${NC}"
    exit 1
fi

if ! command -v docker compose &> /dev/null; then
    echo -e "${RED}Docker Compose não encontrado. Por favor, instale o Docker Compose antes de continuar.${NC}"
    exit 1
fi

# Iniciando os serviços com Docker Compose
echo -e "${GREEN}Iniciando os serviços...${NC}"
docker compose up -d

echo -e "${BLUE}=== Aguardando inicialização dos serviços (30s) ===${NC}"
sleep 30

# Verificando se todos os serviços estão rodando
echo -e "${GREEN}Verificando status dos serviços...${NC}"
if docker compose ps | grep -q "Exit"; then
    echo -e "${RED}Alguns serviços não iniciaram corretamente. Verifique os logs com 'docker compose logs'.${NC}"
    exit 1
fi

echo -e "${BLUE}=== Infraestrutura configurada com sucesso! ===${NC}"
echo -e "${GREEN}Acesse as aplicações em:${NC}"
echo -e "App1 (Python): http://localhost/app1/hello"
echo -e "App2 (Node.js): http://localhost/app2/hello"
echo -e ""
echo -e "${GREEN}Monitore a infraestrutura em:${NC}"
echo -e "Prometheus: http://localhost:9090"
echo -e "Grafana: http://localhost:3001 (admin/admin)"
echo -e ""
echo -e "${BLUE}Para executar o teste de cache, rode:${NC} ./test.sh"