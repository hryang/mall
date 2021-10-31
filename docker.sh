#!/usr/bin/env bash

set -e

echo "Building MySQL image ..."
docker build -f docker/Dockerfile.mysql -t mall/mall-mysql .

echo "Running MySQL container ..."
docker stop mall-mysql && docker rm mall-mysql
docker run -p 3306:3306 --name mall-mysql -d mall/mall-mysql

echo "Running Redis container ..."
docker stop mall-redis && docker rm mall-redis
docker run -p 6379:6379 --name mall-redis -d redis:5 redis-server --appendonly yes

echo "Running MongoDB container ..."
docker stop mall-mongo && docker rm mall-mongo
docker run -p 27017:27017 --name mall-mongo -d mongo:4.2.5

echo "Building RabbitMQ image ..."
docker build -f docker/Dockerfile.rabbitmq -t mall/mall-rabbitmq .

echo "Running RabbitMQ container ..."
docker stop mall-rabbitmq && docker rm mall-rabbitmq
docker run -p 5672:5672 -p 15672:15672 --name mall-rabbitmq -d mall/mall-rabbitmq

echo "Building Elasticsearch image ..."
docker build -f docker/Dockerfile.elasticsearch -t mall/mall-elasticsearch .

echo "Running Elasticsearch container ..."
docker stop mall-elasticsearch && docker rm mall-elasticsearch
docker run -p 9200:9200 -p 9300:9300 --name mall-elasticsearch -d mall/mall-elasticsearch