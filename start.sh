#!/bin/bash

docker build -f Dockerfile --tag lambda:sage .
docker run --name sage lambda:sage
docker cp sage:/tmp/package.zip sagemaker.zip
docker stop sage
