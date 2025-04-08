FROM nginx:1.21-alpine

# Removendo configuração padrão do Nginx
RUN rm /etc/nginx/conf.d/default.conf

# Copiando nossa configuração personalizada
COPY nginx.conf /etc/nginx/nginx.conf

# Criando diretórios de cache
RUN mkdir -p /var/cache/nginx/app1_cache \
    && mkdir -p /var/cache/nginx/app2_cache \
    && chown -R nginx:nginx /var/cache/nginx

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]