#stage 1
ARG APP_NAME=angular-frontend
FROM registry.access.redhat.com/ubi8/nodejs-16:latest as node
RUN useradd -m -b / -s /bin/bash node
RUN chgrp -R 0 /node && \
    chmod -R g=u /node
WORKDIR /node
COPY . .
RUN npm install
RUN npm run build --prod
#stage 2
FROM registry.access.redhat.com/ubi8/nginx-120
COPY --from=node /node/dist/$APP_NAME /usr/share/nginx/html
