# BUILD stage
FROM node:20-alpine AS build
WORKDIR /app
## Execute dependencies separately on the npm run build to reduce build time
COPY package*.json ./
RUN npm ci
##
COPY . .
RUN npm run build

# PRODUCTION stage
FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]