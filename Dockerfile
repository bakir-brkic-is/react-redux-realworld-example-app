FROM node:lts as build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
ARG API_ROOT=https://conduit.productionready.io/api
ENV REACT_APP_API_ROOT=${API_ROOT}
RUN npm run build

FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html