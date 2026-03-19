# React App
FROM node:25-alpine3.22 as build
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Nginx Setup
FROM nginx:alpine-slim
WORKDIR /usr/share/nginx/html
RUN rm -rf * # Remove default nginx static files
COPY --from=build /app/dist . # Copy built React app to nginx directory
EXPOSE 80
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]