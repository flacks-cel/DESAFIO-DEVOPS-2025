const express = require('express');
const app = express();
const port = 3000;
const promClient = require('prom-client');
const winston = require('winston');

// Configuração do Prometheus para métricas
const register = new promClient.Registry();
promClient.collectDefaultMetrics({ register });

// Criando métricas personalizadas
const httpRequestCounter = new promClient.Counter({
  name: 'nodejs_http_requests_total',
  help: 'Total de requisições HTTP',
  labelNames: ['method', 'endpoint', 'status'],
  registers: [register]
});

const httpRequestDuration = new promClient.Histogram({
  name: 'nodejs_http_request_duration_seconds',
  help: 'Duração das requisições HTTP em segundos',
  labelNames: ['method', 'endpoint'],
  registers: [register]
});

// Configuração de logs
const logger = winston.createLogger({
  level: 'info',
  format: winston.format.combine(
    winston.format.timestamp(),
    winston.format.json()
  ),
  transports: [
    new winston.transports.Console()
  ]
});

// Rota para métricas
app.get('/metrics', async (req, res) => {
  res.set('Content-Type', register.contentType);
  res.end(await register.metrics());
});

app.get('/hello', (req, res) => {
  const end = httpRequestDuration.startTimer({ method: 'GET', endpoint: '/hello' });
  logger.info('Recebida requisição em /hello');
  
  res.json({ message: "Olá do Serviço Node.js!" });
  
  httpRequestCounter.inc({ method: 'GET', endpoint: '/hello', status: 200 });
  end();
});

app.get('/time', (req, res) => {
  const end = httpRequestDuration.startTimer({ method: 'GET', endpoint: '/time' });
  logger.info('Recebida requisição em /time');
  
  const now = new Date();
  const formattedTime = now.toISOString().replace('T', ' ').substring(0, 19);
  res.json({ current_time: formattedTime });
  
  httpRequestCounter.inc({ method: 'GET', endpoint: '/time', status: 200 });
  end();
});

app.listen(port, '0.0.0.0', () => {
  logger.info(`Aplicação Node.js iniciada na porta ${port}`);
});