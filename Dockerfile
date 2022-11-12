FROM node:lts-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM node:lts-alpine
WORKDIR /app
RUN npm install -g @web/dev-server
COPY --from=build ./app/dist .
EXPOSE 80
CMD [ "wds", "-p", "80" ]
