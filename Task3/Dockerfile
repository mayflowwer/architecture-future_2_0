FROM node:20-alpine

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install

COPY radar ./radar
COPY public ./public
COPY config.json .
COPY about.md .


RUN npm run build

EXPOSE 3000

CMD ["npm", "run", "serve"]