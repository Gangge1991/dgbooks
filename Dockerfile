FROM node:18-alpine AS builder
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci
COPY docs ./docs
ENV NODE_ENV=production
RUN npm run build

FROM nginx:alpine
COPY --from=builder /app/docs/.vuepress/dist /usr/share/nginx/html
EXPOSE 8090
CMD ["nginx", "-g", "daemon off;"]
