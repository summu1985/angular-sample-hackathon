#stage 1
ARG APP_NAME=angular-frontend
FROM registry.access.redhat.com/ubi8/nodejs-16:latest as node
RUN chgrp -R 0 /usr/src && \
    chmod -R g=u /usr/src
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY . .
RUN npm install
RUN npm run build --prod
#stage 2
FROM registry.access.redhat.com/ubi8/nginx-120
COPY --from=node /usr/src/app/dist/$APP_NAME /usr/share/nginx/html
