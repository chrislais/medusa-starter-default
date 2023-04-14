FROM node:18.16.0

WORKDIR /app

COPY package.json .
COPY develop.sh .
COPY yarn.lock .

RUN yarn --network-timeout 1000000
RUN yarn global add @medusajs/medusa-cli@latest
RUN yarn add @medusajs/admin
#RUN yarn build:admin

COPY . .

ARG JWT_SECRET
ARG COOKIE_SECRET
ARG DATABASE_TYPE
ARG DATABASE_URL
ARG REDIS_URL

ENV JWT_SECRET ${JWT_SECRET:-something}
ENV COOKIE_SECRET ${COOKIE_SECRET:-something}
ENV DATABASE_TYPE ${DATABASE_TYPE:-postgres}
ENV DATABASE_URL ${DATABASE_URL:-postgres://medusa:medusa@postgres:5432/medusa}
ENV REDIS_URL ${REDIS_URL:-redis://redis:6379}

ENTRYPOINT ["sh", "./develop.sh"]