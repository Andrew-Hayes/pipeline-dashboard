#!/bin/bash

set -e
env GOOS=linux go build -o web cmd/web/main.go

cd frontend; yarn build; cd ..

mkdir -p public
cp -R frontend/build/* public/

TIMESTAMP=`date +%s`
docker build --no-cache . -f Dockerfile -t $1:$TIMESTAMP
docker push $1:$TIMESTAMP

rm web
