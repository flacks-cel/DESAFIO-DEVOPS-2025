<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 900 600">
  <!-- Definição de cores -->
  <defs>
    <linearGradient id="blue-gradient" x1="0%" y1="0%" x2="100%" y2="0%">
      <stop offset="0%" stop-color="#4573b9" />
      <stop offset="100%" stop-color="#6c93d7" />
    </linearGradient>
    <linearGradient id="green-gradient" x1="0%" y1="0%" x2="100%" y2="0%">
      <stop offset="0%" stop-color="#5cb85c" />
      <stop offset="100%" stop-color="#8dc88d" />
    </linearGradient>
    <linearGradient id="red-gradient" x1="0%" y1="0%" x2="100%" y2="0%">
      <stop offset="0%" stop-color="#d9534f" />
      <stop offset="100%" stop-color="#e37c79" />
    </linearGradient>
    <linearGradient id="orange-gradient" x1="0%" y1="0%" x2="100%" y2="0%">
      <stop offset="0%" stop-color="#f0ad4e" />
      <stop offset="100%" stop-color="#f5c781" />
    </linearGradient>
    <linearGradient id="purple-gradient" x1="0%" y1="0%" x2="100%" y2="0%">
      <stop offset="0%" stop-color="#9467bd" />
      <stop offset="100%" stop-color="#b893d8" />
    </linearGradient>
    <!-- Sombras -->
    <filter id="shadow" x="-10%" y="-10%" width="120%" height="120%">
      <feDropShadow dx="2" dy="2" stdDeviation="3" flood-opacity="0.3"/>
    </filter>
  </defs>
  
  <!-- Fundo -->
  <rect width="900" height="600" fill="#f8f9fa" />
  
  <!-- Título -->
  <text x="450" y="40" font-family="Arial" font-size="24" font-weight="bold" text-anchor="middle">Arquitetura do Desafio DevOps 2025</text>
  
  <!-- Container Docker Compose -->
  <rect x="50" y="70" width="800" height="480" rx="10" ry="10" fill="#f0f0f0" stroke="#cccccc" stroke-width="2" stroke-dasharray="5,5" />
  <text x="450" y="90" font-family="Arial" font-size="18" font-weight="bold" text-anchor="middle">Infraestrutura Docker Compose</text>
  
  <!-- Nginx Container -->
  <rect x="350" y="120" width="200" height="80" rx="5" ry="5" fill="url(#blue-gradient)" filter="url(#shadow)" />
  <text x="450" y="145" font-family="Arial" font-size="16" font-weight="bold" fill="white" text-anchor="middle">NGINX</text>
  <text x="450" y="170" font-family="Arial" font-size="12" fill="white" text-anchor="middle">Cache Layer</text>
  
  <!-- Network Lines (de Nginx para aplicações) -->
  <line x1="450" y1="200" x2="450" y2="230" stroke="#999999" stroke-width="2" stroke-dasharray="5,3" />
  <line x1="450" y1="230" x2="200" y2="230" stroke="#999999" stroke-width="2" stroke-dasharray="5,3" />
  <line x1="450" y1="230" x2="700" y2="230" stroke="#999999" stroke-width="2" stroke-dasharray="5,3" />
  <line x1="200" y1="230" x2="200" y2="260" stroke="#999999" stroke-width="2" stroke-dasharray="5,3" />
  <line x1="700" y1="230" x2="700" y2="260" stroke="#999999" stroke-width="2" stroke-dasharray="5,3" />
  
  <!-- App Containers -->
  <rect x="100" y="260" width="200" height="80" rx="5" ry="5" fill="url(#green-gradient)" filter="url(#shadow)" />
  <text x="200" y="285" font-family="Arial" font-size="16" font-weight="bold" fill="white" text-anchor="middle">App1: Python/Flask</text>
  <text x="200" y="310" font-family="Arial" font-size="12" fill="white" text-anchor="middle">Cache TTL: 10s</text>
  
  <rect x="600" y="260" width="200" height="80" rx="5" ry="5" fill="url(#green-gradient)" filter="url(#shadow)" />
  <text x="700" y="285" font-family="Arial" font-size="16" font-weight="bold" fill="white" text-anchor="middle">App2: Node.js/Express</text>
  <text x="700" y="310" font-family="Arial" font-size="12" fill="white" text-anchor="middle">Cache TTL: 60s</text>
  
  <!-- Prometheus & Grafana -->
  <rect x="180" y="420" width="160" height="70" rx="5" ry="5" fill="url(#orange-gradient)" filter="url(#shadow)" />
  <text x="260" y="445" font-family="Arial" font-size="16" font-weight="bold" fill="white" text-anchor="middle">Prometheus</text>
  <text x="260" y="465" font-family="Arial" font-size="12" fill="white" text-anchor="middle">Metrics Collection</text>
  
  <rect x="560" y="420" width="160" height="70" rx="5" ry="5" fill="url(#purple-gradient)" filter="url(#shadow)" />
  <text x="640" y="445" font-family="Arial" font-size="16" font-weight="bold" fill="white" text-anchor="middle">Grafana</text>
  <text x="640" y="465" font-family="Arial" font-size="12" fill="white" text-anchor="middle">Monitoring UI</text>
  
  <!-- Network Lines (para monitoramento) -->
  <line x1="200" y1="340" x2="200" y2="370" stroke="#999999" stroke-width="1" stroke-dasharray="3,2" />
  <line x1="700" y1="340" x2="700" y2="370" stroke="#999999" stroke-width="1" stroke-dasharray="3,2" />
  <line x1="450" y1="200" x2="450" y2="370" stroke="#999999" stroke-width="1" stroke-dasharray="3,2" />
  
  <line x1="200" y1="370" x2="700" y2="370" stroke="#999999" stroke-width="1" stroke-dasharray="3,2" />
  <line x1="260" y1="370" x2="260" y2="420" stroke="#999999" stroke-width="1" stroke-dasharray="3,2" />
  <line x1="640" y1="370" x2="640" y2="420" stroke="#999999" stroke-width="1" stroke-dasharray="3,2" />
  
  <!-- Data Flow Arrows -->
  <!-- Cliente para Nginx -->
  <line x1="450" y1="60" x2="450" y2="110" stroke="#000000" stroke-width="2" />
  <polygon points="450,120 445,110 455,110" fill="#000000" />
  <text x="480" y="100" font-family="Arial" font-size="10" text-anchor="left">HTTP Request</text>
  
  <!-- Nginx para Apps -->
  <polygon points="200,250 195,240 205,240" fill="#000000" />
  <text x="210" y="245" font-family="Arial" font-size="10" text-anchor="left">Proxy/Cache</text>
  
  <polygon points="700,250 695,240 705,240" fill="#000000" />
  <text x="710" y="245" font-family="Arial" font-size="10" text-anchor="left">Proxy/Cache</text>
  
  <!-- Métricas para Prometheus -->
  <polygon points="260,410 255,400 265,400" fill="#000000" />
  <text x="270" y="400" font-family="Arial" font-size="10" text-anchor="left">Metrics</text>
  
  <!-- Prometheus para Grafana -->
  <line x1="340" y1="450" x2="560" y2="450" stroke="#000000" stroke-width="2" />
  <polygon points="550,450 540,445 540,455" fill="#000000" />
  <text x="450" y="440" font-family="Arial" font-size="10" text-anchor="middle">Query Metrics</text>
  
  <!-- Volumes -->
  <rect x="100" y="520" width="120" height="30" rx="3" ry="3" fill="#e0e0e0" stroke="#cccccc" stroke-width="1" />
  <text x="160" y="540" font-family="Arial" font-size="12" text-anchor="middle">Nginx Cache</text>
  
  <rect x="240" y="520" width="120" height="30" rx="3" ry="3" fill="#e0e0e0" stroke="#cccccc" stroke-width="1" />
  <text x="300" y="540" font-family="Arial" font-size="12" text-anchor="middle">Prometheus Data</text>
  
  <rect x="380" y="520" width="120" height="30" rx="3" ry="3" fill="#e0e0e0" stroke="#cccccc" stroke-width="1" />
  <text x="440" y="540" font-family="Arial" font-size="12" text-anchor="middle">Grafana Data</text>
  
  <!-- Legenda -->
  <rect x="550" y="520" width="20" height="10" fill="url(#green-gradient)" />
  <text x="580" y="530" font-family="Arial" font-size="12" text-anchor="left">Application Services</text>
  
  <rect x="550" y="540" width="20" height="10" fill="url(#blue-gradient)" />
  <text x="580" y="550" font-family="Arial" font-size="12" text-anchor="left">Cache Layer</text>
  
  <rect x="550" y="560" width="20" height="10" fill="url(#orange-gradient)" />
  <text x="580" y="570" font-family="Arial" font-size="12" text-anchor="left">Metrics Collection</text>
  
  <rect x="700" y="520" width="20" height="10" fill="url(#purple-gradient)" />
  <text x="730" y="530" font-family="Arial" font-size="12" text-anchor="left">Monitoring</text>
  
  <rect x="700" y="540" width="20" height="10" fill="#e0e0e0" stroke="#cccccc" stroke-width="1" />
  <text x="730" y="550" font-family="Arial" font-size="12" text-anchor="left">Persistent Volumes</text>
  
  <line x1="700" y1="565" x2="720" y2="565" stroke="#999999" stroke-width="1" stroke-dasharray="3,2" />
  <text x="730" y="570" font-family="Arial" font-size="12" text-anchor="left">Network Connection</text>
</svg>