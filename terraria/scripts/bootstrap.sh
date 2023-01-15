#!/bin/bash

if [[ -z "${SERVER_VERSION}" ]]; then
  echo Environment 'SERVER_VERSION' must be defined!
  exit 1
fi

FILE=/terraria/TerrariaServer.bin.x86_64
if [ ! -f "$FILE" ]; then
  echo "## Installig Terraria server files..."

  apt update && apt install wget unzip -y

  #apk add --update-cache \
  #  unzip \
  #  wget

  # apk del .build-dependencies

  mkdir -p /terraria

  wget -O /terraria/server.zip https://terraria.org/api/download/pc-dedicated-server/terraria-server-$SERVER_VERSION.zip

  unzip /terraria/server.zip -d /terraria
  mv /terraria/$SERVER_VERSION/Linux/* /terraria
  chmod +x /terraria/TerrariaServer.bin.x86_64
fi

cd /terraria

echo "## Starting server"
/terraria/TerrariaServer.bin.x86_64 -config /terraria/serverconfig.txt
