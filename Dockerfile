#stage 1
ARG APP_NAME=angular-frontend
USER 1001
FROM registry.access.redhat.com/ubi8/nodejs-16:latest as node
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build --prod
#stage 2
FROM registry.access.redhat.com/ubi8/nginx-120
COPY --from=node /app/dist/$APP_NAME /usr/share/nginx/html
