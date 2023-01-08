FROM node:16-alpine

WORKDIR /app

RUN apk update && apk upgrade
RUN apk add git

COPY ./package*.json /app/
COPY ./yarn.lock /app/

RUN yarn
RUN npm cache clean --force
RUN npm run build

COPY . .

ENV PATH ./node_modules/.bin/:$PATH
