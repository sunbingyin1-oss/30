FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production

FROM node:18-alpine
WORKDIR /app
RUN apk add --no-cache openssl curl bash coreutils iproute2
COPY --from=builder /app/node_modules ./node_modules
COPY . .
RUN chmod +x index.js
EXPOSE 3000
ENV NODE_ENV=production
CMD ["node", "index.js"]
