FROM node:24.2.0-alpine3.22
WORKDIR /app
COPY src/package*.json .
RUN npm install
COPY src/ .
EXPOSE 8080
CMD [ "node", "server.js" ]