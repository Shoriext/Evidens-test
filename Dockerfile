FROM node:18-slim

RUN apt-get update && apt-get install -y \
    git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY package*.json ./

RUN npm ci

COPY . .

RUN npm run sources

EXPOSE 3000

CMD ["npm", "exec", "evidence", "dev", "--", "--host", "0.0.0.0"]