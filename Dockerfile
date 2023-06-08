#stage 1
ARG APP_NAME=angular-frontend
FROM node:16.17.0 as node
#RUN chgrp -R 0 /opt
#RUN chmod -R g=u /opt
#RUN mkdir -p /opt/approot/src
#WORKDIR /opt/approot/src
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build --prod
#stage 2
FROM registry.access.redhat.com/ubi8/nginx-120
COPY --from=node /opt/approot/src/dist/$APP_NAME /usr/share/nginx/html
