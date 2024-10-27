# Use Node.js version 18
FROM node:18

# Set the working directory inside the container
WORKDIR /app

# Copy package files and install dependencies to optimize caching
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application files
COPY . .

# Expose the port the application will run on inside the container
EXPOSE 3000

# Default command to run the application
#CMD ["npm", "start"]
CMD ["node", "index.js"]




# Builder stage

#FROM node:20-alpine AS builder
#WORKDIR /app
#COPY package.json package-lock.json ./
#RUN npm ci
#COPY . .
#RUN npm run build

# Runner stage (Production)

#FROM node:20-alpine AS runner
#WORKDIR /app
#COPY --from=builder /app ./
#RUN npm ci --only=production  #install dependencies
#EXPOSE 3000
#CMD ["node", "build/index.js"]

# Developer stage

#FROM node:20-alpine AS developer
#WORKDIR /app
#COPY package.json package-lock.json ./    #copy package
#RUN npm ci
#COPY . .
#EXPOSE 3000
#CMD ["npx", "turbo", "dev"]
