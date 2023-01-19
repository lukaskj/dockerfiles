

if [[ -z "${STEAM_USERNAME}" ]]; then
  echo 'STEAM_USERNAME' environment not defined.
  exit 1
fi

# TODO check environment variable to force update
steamcmd +login $STEAM_USERNAME +force_install_dir /starbound +app_update 533830 +quit

# Must CD to folder
cd /starbound/linux/
chmod +x ./starbound_server
./starbound_server