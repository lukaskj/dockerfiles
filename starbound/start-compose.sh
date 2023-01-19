#!/bin/bash

docker compose up -d

if [ $? != 0 ] 
then 
  echo "Error creating the container."
  exit 2
fi

STARBOUND_CONTAINER=$(docker ps -a --no-trunc -f name=starbound --format "{{.Names}}" | tail -1)

docker attach $STARBOUND_CONTAINER