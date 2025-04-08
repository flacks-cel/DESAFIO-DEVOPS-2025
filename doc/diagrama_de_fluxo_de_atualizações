<svg xmlns="http://www.w3.org/2000/svg" viewBox
="0 0 900 600">
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
    <linearGradient id="yellow-gradient" x1="0%" y1="0%" x2="100%" y2="0%">
      <stop offset="0%" stop-color="#f0ad4e" />
      <stop offset="100%" stop-color="#f5c781" />
    </linearGradient>
    <linearGradient id="red-gradient" x1="0%" y1="0%" x2="100%" y2="0%">
      <stop offset="0%" stop-color="#d9534f" />
      <stop offset="100%" stop-color="#e37c79" />
    </linearGradient>
    <linearGradient id="gray-gradient" x1="0%" y1="0%" x2="100%" y2="0%">
      <stop offset="0%" stop-color="#6c757d" />
      <stop offset="100%" stop-color="#868e96" />
    </linearGradient>
    <filter id="shadow" x="-10%" y="-10%" width="120%" height="120%">
      <feDropShadow dx="2" dy="2" stdDeviation="3" flood-opacity="0.3"/>
    </filter>
  </defs>
  
  <!-- Fundo -->
  <rect width="900" height="600" fill="#f8f9fa" />
  
  <!-- Título -->
  <text x="450" y="40" font-family="Arial" font-size="24" font-weight="bold" text-anchor="middle">Fluxo de Atualização de Componentes</text>
  
  <!-- Repositório Git -->
  <rect x="350" y="70" width="200" height="70" rx="5" ry="5" fill="url(#blue-gradient)" filter="url(#shadow)" />
  <text x="450" y="105" font-family="Arial" font-size="16" font-weight="bold" fill="white" text-anchor="middle">Repositório Git</text>
  <text x="450" y="125" font-family="Arial" font-size="12" fill="white" text-anchor="middle">Código-fonte e Configurações</text>
  
  <!-- CI/CD Pipeline -->
  <rect x="350" y="170" width="200" height="70" rx="5" ry="5" fill="url(#green-gradient)" filter="url(#shadow)" />
  <text x="450" y="205" font-family="Arial" font-size="16" font-weight="bold" fill="white" text-anchor="middle">CI/CD Pipeline</text>
  <text x="450" y="225" font-family="Arial" font-size="12" fill="white" text-anchor="middle">Build, Test e Deploy</text>
  
  <!-- Arrows from Git to CI/CD -->
  <line x1="450" y1="140" x2="450" y2="160" stroke="#000000" stroke-width="2" />
  <polygon points="450,170 445,160 455,160" fill="#000000" />
  <text x="470" y="155" font-family="Arial" font-size="10" text-anchor="left">git push</text>
  
  <!-- Docker Registry -->
  <rect x="350" y="270" width="200" height="70" rx="5" ry="5" fill="url(#gray-gradient)" filter="url(#shadow)" />
  <text x="450" y="305" font-family="Arial" font-size="16" font-weight="bold" fill="white" text-anchor="middle">Docker Registry</text>
  <text x="450" y="325" font-family="Arial" font-size="12" fill="white" text-anchor="middle">Imagens Docker</text>
  
  <!-- Arrows from CI/CD to Docker Registry -->
  <line x1="450" y1="240" x2="450" y2="260" stroke="#000000" stroke-width="2" />
  <polygon points="450,270 445,260 455,260" fill="#000000" />
  <text x="470" y="255" font-family="Arial" font-size="10" text-anchor="left">docker push</text>
  
  <!-- Componentes da Infraestrutura -->
  <rect x="100" y="400" width="150" height="60" rx="5" ry="5" fill="url(#blue-gradient)" filter="url(#shadow)" />
  <text x="175" y="430" font-family="Arial" font-size="14" font-weight="bold" fill="white" text-anchor="middle">Nginx</text>
  <text x="175" y="450" font-family="Arial" font-size="12" fill="white" text-anchor="middle">Camada de Cache</text>
  
  <rect x="270" y="400" width="150" height="60" rx="5" ry="5" fill="url(#green-gradient)" filter="url(#shadow)" />
  <text x="345" y="430" font-family="Arial" font-size="14" font-weight="bold" fill="white" text-anchor="middle">App1 (Python)</text>
  <text x="345" y="450" font-family="Arial" font-size="12" fill="white" text-anchor="middle">Aplicação Backend</text>
  
  <rect x="440" y="400" width="150" height="60" rx="5" ry="5" fill="url(#green-gradient)" filter="url(#shadow)" />
  <text x="515" y="430" font-family="Arial" font-size="14" font-weight="bold" fill="white" text-anchor="middle">App2 (Node.js)</text>
  <text x="515" y="450" font-family="Arial" font-size="12" fill="white" text-anchor="middle">Aplicação Backend</text>
  
  <rect x="610" y="400" width="150" height="60" rx="5" ry="5" fill="url(#yellow-gradient)" filter="url(#shadow)" />
  <text x="685" y="430" font-family="Arial" font-size="14" font-weight="bold" fill="white" text-anchor="middle">Monitoramento</text>
  <text x="685" y="450" font-family="Arial" font-size="12" fill="white" text-anchor="middle">Prometheus/Grafana</text>
  
  <!-- Fluxos de Atualização -->
  <line x1="350" y1="340" x2="175" y2="390" stroke="#000000" stroke-width="2" />
  <polygon points="175,400 170,390 180,390" fill="#000000" />
  
  <line x1="400" y1="340" x2="345" y2="390" stroke="#000000" stroke-width="2" />
  <polygon points="345,400 340,390 350,390" fill="#000000" />
  
  <line x1="500" y1="340" x2="515" y2="390" stroke="#000000" stroke-width="2" />
  <polygon points="515,400 510,390 520,390" fill="#000000" />
  
  <line x1="550" y1="340" x2="685" y2="390" stroke="#000000" stroke-width="2" />
  <polygon points="685,400 680,390 690,390" fill="#000000" />
  
  <!-- Fluxos de Atualização por Componente -->
  <rect x="50" y="510" width="800" height="80" rx="5" ry="5" fill="#f0f0f0" stroke="#cccccc" stroke-width="1" />
  
  <text x="100" y="530" font-family="Arial" font-size="12" font-weight="bold" text-anchor="left">Nginx:</text>
  <text x="150" y="530" font-family="Arial" font-size="12" text-anchor="left">1. Alterar nginx.conf -> 2. Construir imagem -> 3. Recarregar configuração (sem downtime)</text>
  
  <text x="100" y="550" font-family="Arial" font-size="12" font-weight="bold" text-anchor="left">App1:</text>
  <text x="150" y="550" font-family="Arial" font-size="12" text-anchor="left">1. Atualizar código Python -> 2. Construir imagem -> 3. Atualizar contêiner (rolling update)</text>
  
  <text x="100" y="570" font-family="Arial" font-size="12" font-weight="bold" text-anchor="left">App2:</text>
  <text x="150" y="570" font-family="Arial" font-size="12" text-anchor="left">1. Atualizar código Node.js -> 2. Construir imagem -> 3. Atualizar contêiner (rolling update)</text>
  
  <text x="100" y="590" font-family="Arial" font-size="12" font-weight="bold" text-anchor="left">Monitoramento:</text>
  <text x="150" y="590" font-family="Arial" font-size="12" text-anchor="left">1. Atualizar configurações -> 2. Aplicar mudanças (hot reload)</text>