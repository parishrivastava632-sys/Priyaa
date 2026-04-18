# Use official nginx to serve static files
FROM nginx:alpine

# Copy the preview HTML to nginx's default public directory
COPY preview.html /usr/share/nginx/html/index.html

# Copy nginx config for SPA routing
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 8080
