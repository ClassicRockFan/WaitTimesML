#### BUILD IMAGE ####
FROM node:22-alpine as build

WORKDIR /app

COPY . /app

RUN npm i

#### PROD IMAGE ####
FROM node:22-alpine as prod

WORKDIR /app

ENV NODE_ENV=production

COPY --from=build /app/server.js /app/server.js
COPY --from=build /app/config/ /app/config/
COPY --from=build /app/node_modules/ /app/node_modules/

ENTRYPOINT node ./server.js
