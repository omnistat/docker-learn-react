# This docker file is used for production (sorta)
# This will build the react app and then transfer the build to a nginx build

# Tag as 'builder'
FROM node:18-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Start run phase
FROM nginx
# Transfer build files generated in /app/build from builder phase for nginx
COPY --from=builder  /app/build /usr/share/nginx/html
# Nginx starts automatically in the image

