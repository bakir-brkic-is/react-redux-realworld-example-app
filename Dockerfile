FROM node:lts as build
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build
# CMD npm start

FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html