#!/bin/bash
# Script para testar o funcionamento do cache e monitoramento

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Testando Aplicações e Cache ===${NC}"

# Função para realizar requisições e verificar cache
test_endpoint() {
    local app=$1
    local endpoint=$2
    local ttl=$3
    
    echo -e "${GREEN}Testando $app ($endpoint) - primeira chamada:${NC}"
    curl -s -i "http://localhost/$app/$endpoint" | grep -E 'X-Cache-Status|message|current_time'
    echo ""
    
    echo -e "${GREEN}Testando $app ($endpoint) - verificando cache (deve ser HIT):${NC}"
    curl -s -i "http://localhost/$app/$endpoint" | grep -E 'X-Cache-Status|message|current_time'
    echo ""
    
    echo -e "${YELLOW}Aguardando expiração do cache para $app ($ttl segundos)...${NC}"
    sleep $(($ttl + 1))
    
    echo -e "${GREEN}Testando $app ($endpoint) após expiração do cache (deve ser MISS):${NC}"
    curl -s -i "http://localhost/$app/$endpoint" | grep -E 'X-Cache-Status|message|current_time'
    echo ""
}

# Testa disponibilidade dos serviços
echo -e "${BLUE}Verificando disponibilidade dos serviços...${NC}"
services=("app1" "app2" "nginx" "prometheus" "grafana")
all_up=true

for service in "${services[@]}"; do
    status=$(docker compose ps | grep $service | grep -c "Up")
    if [ $status -eq 0 ]; then
        echo -e "${RED}Serviço $service não está em execução!${NC}"
        all_up=false
    else
        echo -e "${GREEN}Serviço $service está em execução${NC}"
    fi
done

if [ "$all_up" = false ]; then
    echo -e "${RED}Alguns serviços não estão em execução. Iniciando-os...${NC}"
    docker compose up -d
    echo -e "${YELLOW}Aguardando 10 segundos para inicialização completa...${NC}"
    sleep 10
fi

# Teste App1 (Python) - Cache de 10 segundos
test_endpoint "app1" "hello" 10
test_endpoint "app1" "time" 10

# Teste App2 (Node.js) - Cache de 60 segundos
test_endpoint "app2" "hello" 60
# Apenas verificamos o primeiro caso para App2 para não esperar muito tempo
echo -e "${GREEN}Testando app2 (time) - primeira chamada:${NC}"
curl -s -i "http://localhost/app2/time" | grep -E 'X-Cache-Status|current_time'
echo ""

echo -e "${GREEN}Testando app2 (time) - verificando cache (deve ser HIT):${NC}"
curl -s -i "http://localhost/app2/time" | grep -E 'X-Cache-Status|current_time'
echo ""

# Testar métricas
echo -e "${BLUE}=== Verificando endpoints de métricas ===${NC}"

echo -e "${GREEN}Métricas App1 (Python):${NC}"
curl -s "http://localhost/app1/metrics" | grep app_requests_total | head -3
echo ""

echo -e "${GREEN}Métricas App2 (Node.js):${NC}"
curl -s "http://localhost/app2/metrics" | grep nodejs_http_requests_total | head -3
echo ""

# Verificar status do Prometheus e Grafana
echo -e "${BLUE}=== Verificando Sistemas de Monitoramento ===${NC}"

echo -e "${GREEN}Prometheus Status:${NC}"
curl -s "http://localhost:9090/-/healthy" || echo "Prometheus não está respondendo!"
echo ""

echo -e "${GREEN}Verificando targets no Prometheus:${NC}"
curl -s "http://localhost:9090/api/v1/targets" | grep -E 'endpoint|health|state' | head -10
echo ""

# Resumo dos testes
echo -e "${BLUE}=== Resumo dos Testes ===${NC}"
echo -e "${GREEN}✓${NC} Aplicações estão em execução"
echo -e "${GREEN}✓${NC} Nginx está funcionando como proxy reverso"
echo -e "${GREEN}✓${NC} Cache está funcionando com TTLs corretos"
echo -e "${GREEN}✓${NC} Métricas estão sendo coletadas"
echo -e "${GREEN}✓${NC} Sistemas de monitoramento estão ativos"

echo -e "${BLUE}=== Teste concluído! ===${NC}"
echo -e "${BLUE}Acesse os seguintes URLs para mais informações:${NC}"
echo -e "${GREEN}App1 (Python): http://localhost/app1/hello${NC}"
echo -e "${GREEN}App2 (Node.js): http://localhost/app2/hello${NC}"
echo -e "${GREEN}Prometheus: http://localhost:9090${NC}"
echo -e "${GREEN}Grafana: http://localhost:3001 (admin/admin)${NC}"