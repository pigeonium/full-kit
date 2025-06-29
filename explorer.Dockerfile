FROM node:18-alpine as builder

WORKDIR /app

COPY ./web_explorer /app

RUN sed -i 's|http://127.0.0.1:14540|/api/|g' /app/univ.js

FROM nginx:1.21-alpine

COPY --from=builder /app /usr/share/nginx/html

COPY nginx.conf /etc/nginx/conf.d/default.conf