# Makefile para facilitar a execução de comandos comuns

.PHONY: setup start stop restart status logs test clean rebuild help update-app1 update-app2 update-nginx reload-nginx

# Cores
GREEN = \033[0;32m
BLUE = \033[0;34m
YELLOW = \033[0;33m
RED = \033[0;31m
NC = \033[0m

help:
	@echo "${BLUE}=== Desafio DevOps 2025 - Comandos Disponíveis ===${NC}"
	@echo "${GREEN}setup${NC}              - Configura o ambiente e inicia os serviços"
	@echo "${GREEN}start${NC}              - Inicia todos os serviços"
	@echo "${GREEN}stop${NC}               - Para todos os serviços"
	@echo "${GREEN}restart${NC}            - Reinicia todos os serviços"
	@echo "${GREEN}status${NC}             - Mostra o status dos serviços"
	@echo "${GREEN}logs${NC}               - Mostra logs de todos os serviços"
	@echo "${GREEN}logs-app1${NC}          - Mostra logs da aplicação Python"
	@echo "${GREEN}logs-app2${NC}          - Mostra logs da aplicação Node.js"
	@echo "${GREEN}logs-nginx${NC}         - Mostra logs do Nginx"
	@echo "${GREEN}test${NC}               - Executa testes para verificar o funcionamento"
	@echo "${GREEN}clean${NC}              - Remove contêineres, volumes e redes"
	@echo "${GREEN}rebuild${NC}            - Reconstrói e reinicia todos os serviços"
	@echo "${GREEN}update-app1${NC}        - Atualiza apenas a aplicação Python"
	@echo "${GREEN}update-app2${NC}        - Atualiza apenas a aplicação Node.js"
	@echo "${GREEN}update-nginx${NC}       - Atualiza a configuração do Nginx"
	@echo "${GREEN}reload-nginx${NC}       - Recarrega a configuração do Nginx sem reinício"

setup:
	@echo "${BLUE}Configurando o ambiente...${NC}"
	@chmod +x setup.sh
	@./setup.sh

start:
	@echo "${BLUE}Iniciando serviços...${NC}"
	@docker compose up -d
	@echo "${GREEN}Serviços iniciados com sucesso!${NC}"

stop:
	@echo "${BLUE}Parando serviços...${NC}"
	@docker compose down
	@echo "${GREEN}Serviços parados com sucesso!${NC}"

restart:
	@echo "${BLUE}Reiniciando serviços...${NC}"
	@docker compose restart
	@echo "${GREEN}Serviços reiniciados com sucesso!${NC}"

status:
	@echo "${BLUE}Status dos serviços:${NC}"
	@docker compose ps

logs:
	@docker compose logs --tail=100 -f

logs-app1:
	@docker compose logs --tail=100 -f app1

logs-app2:
	@docker compose logs --tail=100 -f app2

logs-nginx:
	@docker compose logs --tail=100 -f nginx

test:
	@echo "${BLUE}Executando testes...${NC}"
	@chmod +x test.sh
	@./test.sh

clean:
	@echo "${YELLOW}ATENÇÃO: Esta ação removerá todos os contêineres, volumes e redes.${NC}"
	@read -p "Deseja continuar? (y/n) " answer; \
	if [ "$$answer" = "y" ]; then \
		echo "${BLUE}Limpando ambiente...${NC}"; \
		docker compose down -v; \
		echo "${GREEN}Ambiente limpo com sucesso!${NC}"; \
	else \
		echo "${BLUE}Operação cancelada.${NC}"; \
	fi

rebuild:
	@echo "${BLUE}Reconstruindo todos os serviços...${NC}"
	@docker compose down
	@docker compose build
	@docker compose up -d
	@echo "${GREEN}Serviços reconstruídos e iniciados com sucesso!${NC}"

update-app1:
	@echo "${BLUE}Atualizando aplicação Python...${NC}"
	@docker compose build app1
	@docker compose up -d app1
	@echo "${GREEN}Aplicação Python atualizada com sucesso!${NC}"

update-app2:
	@echo "${BLUE}Atualizando aplicação Node.js...${NC}"
	@docker compose build app2
	@docker compose up -d app2
	@echo "${GREEN}Aplicação Node.js atualizada com sucesso!${NC}"

update-nginx:
	@echo "${BLUE}Atualizando configuração do Nginx...${NC}"
	@docker compose build nginx
	@docker compose up -d nginx
	@echo "${GREEN}Configuração do Nginx atualizada com sucesso!${NC}"

reload-nginx:
	@echo "${BLUE}Recarregando configuração do Nginx...${NC}"
	@docker compose exec nginx nginx -s reload
	@echo "${GREEN}Configuração do Nginx recarregada com sucesso!${NC}"