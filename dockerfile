# Stage 1: Compile and Build Angular codebase
FROM node:18-alpine as build

# Set the working directory
WORKDIR /usr/local/app

# Add the source code to app
COPY ./angular-docker /usr/local/app/

# Install all the dependencies
RUN npm ci --quiet

# Generate the build of the application
RUN npm run build --prod


# Stage 2: Serve app with nginx server
FROM nginx:stable-alpine

# Copy the build output to replace the default nginx contents
COPY --from=build /usr/local/app/dist/angular-docker /usr/share/nginx/html

# Expose port 9003
EXPOSE 9003

# Optional: Add custom NGINX configuration if required
# COPY ./nginx.conf /etc/nginx/conf.d/default.conf
