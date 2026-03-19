# React App
FROM node:25-alpine3.22 AS build
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Nginx Setup
FROM nginx:alpine-slim
WORKDIR /usr/share/nginx/html
RUN rm -rf * # Remove default nginx static files
# Copy built React app to nginx directory.
COPY --from=build /app/dist/ /usr/share/nginx/html/
EXPOSE 80
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]