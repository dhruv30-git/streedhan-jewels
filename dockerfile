FROM nginxinc/nginx-unprivileged:stable-alpine
COPY deploy/nginx-container.conf /etc/nginx/conf.d/default.conf
COPY index.html /usr/share/nginx/html/index.html
EXPOSE 8080
