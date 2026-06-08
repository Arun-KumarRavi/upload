# Multi-stage build: build a frontend (React/Vite/etc.) and serve with nginx
FROM node:18-alpine AS builder

WORKDIR /app

# copy package files and install dependencies
COPY package*.json ./
RUN npm ci --silent

# copy source and build
COPY . .
RUN npm run build || npm run build:prod || echo "No build script found — ensure your frontend has a build step"

# Serve with nginx
FROM nginx:stable-alpine AS runner

# Remove default nginx content and copy build output
RUN rm -rf /usr/share/nginx/html/*
COPY --from=builder /app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
