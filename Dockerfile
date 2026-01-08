# Build Phase
FROM node:alpine as builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
# CHANGED: Use RUN instead of CMD to build the app during image creation
RUN npm run build

# Run Phase
FROM nginx
# AWS Elastic Beanstalk maps port 80 automatically
EXPOSE 80
# CHANGED: Removed the extra "Dockerfile.yaml" text at the end
COPY --from=builder /app/build /usr/share/nginx/html