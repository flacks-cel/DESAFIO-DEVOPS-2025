from flask import Flask, jsonify
import time
import logging
from prometheus_client import Counter, Histogram, generate_latest, CONTENT_TYPE_LATEST

app = Flask(__name__)

# Configurando observabilidade com Prometheus
REQUEST_COUNT = Counter('app_requests_total', 'Total app HTTP requests', ['method', 'endpoint', 'status'])
REQUEST_LATENCY = Histogram('app_request_latency_seconds', 'Request latency in seconds', ['method', 'endpoint'])

# Configuração de logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(name)s - %(levelname)s - %(message)s')
logger = logging.getLogger("app1-python")

@app.route('/metrics')
def metrics():
    return generate_latest(), 200, {'Content-Type': CONTENT_TYPE_LATEST}

@app.route('/hello')
def hello():
    start_time = time.time()
    logger.info("Recebida requisição em /hello")
    
    response = jsonify({"message": "Olá do Serviço Python!"})
    
    # Métricas
    REQUEST_COUNT.labels('GET', '/hello', '200').inc()
    REQUEST_LATENCY.labels('GET', '/hello').observe(time.time() - start_time)
    
    return response

@app.route('/time')
def current_time():
    start_time = time.time()
    logger.info("Recebida requisição em /time")
    
    response = jsonify({"current_time": time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())})
    
    # Métricas
    REQUEST_COUNT.labels('GET', '/time', '200').inc()
    REQUEST_LATENCY.labels('GET', '/time').observe(time.time() - start_time)
    
    return response

if __name__ == '__main__':
    logger.info("Iniciando aplicação Python na porta 5000")
    app.run(host='0.0.0.0', port=5000)