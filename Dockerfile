FROM node:16-alpine as builder

#En windows esto trae conflico con los volumenes de docker compose
WORKDIR '/app'

#si ponemos el package.json, si se encuentra un cambio ahi, hara un npm install, de lo contario no
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
