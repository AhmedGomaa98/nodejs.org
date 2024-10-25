# Builder stage

FROM node:20-alpine AS builder
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci
COPY . .
RUN npm run build

# Runner stage (Production)

FROM node:20-alpine AS runner
WORKDIR /app
COPY --from=builder /app ./
RUN npm ci --only=production  #install dependencies
EXPOSE 3000
CMD ["node", "build/index.js"]

# Developer stage

FROM node:20-alpine AS developer
WORKDIR /app
COPY package.json package-lock.json ./    #copy package
RUN npm ci
COPY . .
EXPOSE 3000
CMD ["npx", "turbo", "dev"]
