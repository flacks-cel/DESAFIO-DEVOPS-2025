# Guia de Contribuição

Obrigado por considerar contribuir com o projeto **Desafio DevOps 2025**. Este documento fornece diretrizes e instruções para contribuir com este projeto.

## Processo de Contribuição

1. **Fork** o repositório
2. **Clone** o seu fork para sua máquina local
3. **Crie uma branch** para sua feature ou correção
4. **Desenvolva** suas alterações
5. **Teste** tudo localmente
6. **Commit** suas mudanças com mensagens claras
7. **Push** para o seu fork
8. Abra um **Pull Request**

## Estrutura do Projeto

```
.
├── app1-python/           # Aplicação Python/Flask
├── app2-nodejs/           # Aplicação Node.js/Express
├── nginx/                 # Configuração do Nginx
├── prometheus/            # Configuração do Prometheus
├── docker-compose.yml     # Definição dos serviços
├── setup.sh               # Script de inicialização
└── test.sh                # Script de testes
```

## Padrões e Boas Práticas

### Código e Commits

- Use nomes descritivos para variáveis e funções
- Documente seu código quando necessário
- Escreva mensagens de commit significativas que expliquem "por quê", não apenas "o quê"
- Use o formato: `[Componente] Descrição curta do que foi feito`
- Exemplo: `[App1] Adiciona endpoint de saúde para monitoramento`

### Pull Requests

- Descreva claramente o propósito do PR
- Vincule issues relacionadas
- Inclua instruções de teste quando aplicável
- Certifique-se que todos os testes passam

## Fluxo de Desenvolvimento

### Configurando o Ambiente

```bash
# Clone o repositório
git clone https://github.com/seu-usuario/desafio-devops-2025.git
cd desafio-devops-2025

# Configure o ambiente de desenvolvimento
./setup.sh
```

### Testando suas Alterações

```bash
# Reconstruir serviços específicos após alterações
docker-compose build <serviço>
docker-compose up -d <serviço>

# Executar testes
./test.sh
```

## Diretrizes por Componente

### Aplicações (Python/Node.js)

- Mantenha as dependências atualizadas
- Siga as convenções de código da linguagem
- Adicione testes unitários para novas funcionalidades
- Mantenha a instrumentação de métricas consistente

### Nginx

- Mantenha a configuração limpa e bem comentada
- Teste localmente para garantir que todas as rotas funcionam
- Verifique que o cache funciona conforme esperado

### Monitoramento

- Adicione métricas relevantes
- Documente dashboards criados
- Mantenha alertas significativos (evite ruído)

## Problemas e Sugestões

Se você encontrar problemas ou tiver sugestões de melhorias:

1. Verifique se já existe uma issue relacionada
2. Se não existir, crie uma nova issue com:
   - Uma descrição clara do problema/sugestão
   - Etapas para reproduzir (se aplicável)
   - Comportamento esperado vs. atual
   - Capturas de tela (se útil)
   - Informações do ambiente (SO, versões, etc.)

## Lançamento de Versões

O projeto segue o Versionamento Semântico:
- **MAJOR** para mudanças incompatíveis
- **MINOR** para adições com compatibilidade
- **PATCH** para correções com compatibilidade

## Código de Conduta

- Seja respeitoso e inclusivo
- Aceite feedback construtivo
- Foque na melhoria do projeto
- Colabore de forma profissional

---

Novamente, obrigado por contribuir com este projeto! Suas contribuições são valiosas para tornar esta solução ainda melhor.