FROM node:16.17.0 as builder
WORKDIR /opt/app-root/src
COPY . .
RUN npm install
RUN npm run build 
#stage 2
FROM nginx:latest
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=builder /opt/app-root/src/dist/angular-frontend/ /usr/share/nginx/html/
RUN chown -R 1001:0 /usr/share/nginx/html && chmod -R ug+rwx /usr/share/nginx/html
# RUN chgrp -R 0 /etc/nginx
# RUN chmod -R g=u /etc/nginx
USER 1001
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
