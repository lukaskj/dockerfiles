#!/bin/sh
set -e

export TEMP_ARCH=$(dpkg --print-architecture)
export ARCH="${TEMP_ARCH:-amd64}"
export GOSUVERSION="${1:-1.17}"


FILE=/usr/local/bin/gosu
if [ ! -f "$FILE" ]; then
  echo "################################"
  echo "# Installing gosu version $GOSUVERSION #"
  echo "################################"

  wget -q -O /usr/local/bin/gosu https://github.com/tianon/gosu/releases/download/$GOSUVERSION/gosu-$ARCH
  chmod +x /usr/local/bin/gosu
else
  echo "Gosu found!"
fi

if gosu nobody:root bash -c 'whoami' >/dev/null 2>&1; then
  echo 'Success!'
else
  echo 'Error: gosu failed to install.'
  rm /usr/local/bin/gosu 2>/dev/null >/dev/null
  exit 1
fi

echo Done!
echo
