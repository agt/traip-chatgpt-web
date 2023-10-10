#!/bin/ash

RUN npm install http-server

SRV_PORT=${SRV_PORT:-8000}

VITE_API_BASE=${OPENAI_API_BASE:-https://its-llamarama.ucsd.edu/}
VITE_ENDPOINT_COMPLETIONS=${OPENAI_ENDPOINT_COMPLETIONS:-/v1/chat/completions}
VITE_ENDPOINT_MODELS=${OPENAI_ENDPOINT_MODELS:-/v1/models}

cd /chatgpt-web

cat /dev/null > .env
echo "VITE_API_BASE=${VITE_API_BASE}" >> .env
echo "VITE_ENDPOINT_COMPLETIONS=${VITE_ENDPOINT_COMPLETIONS}" >> .env
echo "VITE_ENDPOINT_MODELS=${VITE_ENDPOINT_MODELS}" >> .env

npm run build:github
ln -s . dist/chatgpt-web

exec node_modules/http-server/bin/http-server dist/ -p ${SRV_PORT} -d false --no-dotfiles -r --log-ip

