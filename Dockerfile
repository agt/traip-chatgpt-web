FROM node:18-alpine

RUN mkdir /chatgpt-web && cd /chatgpt-web && \
    wget -O - \
    https://api.github.com/repos/Niek/chatgpt-web/tarball/5f41779af205281774b75781eebcd944d7d9e075 \
        | tar xvzf - --strip-components 1

WORKDIR /chatgpt-web

RUN npm install http-server

COPY vita.env .env

RUN npm ci && npm run build:github && ln -s . dist/chatgpt-web

CMD node_modules/http-server/bin/http-server dist/ -p 8000 -d false --no-dotfiles -r --log-ip

