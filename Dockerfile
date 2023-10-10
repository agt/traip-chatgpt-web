FROM node:18-alpine

RUN mkdir /chatgpt-web && cd /chatgpt-web && \
    wget -O - \
    https://api.github.com/repos/Niek/chatgpt-web/tarball/5f41779af205281774b75781eebcd944d7d9e075 \
        | tar xvzf - --strip-components 1

WORKDIR /chatgpt-web

RUN npm install http-server

RUN npm ci

COPY --chmod=0755 entrypoint.sh /entrypoint.sh

CMD /entrypoint.sh

