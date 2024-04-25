# original script by https://github.com/astorks/PaperMC.sh/blob/master/papermc.sh

set -e

PAPERMC_VERSION=$1
LATEST_BUILD=$(curl -s "https://papermc.io/api/v2/projects/paper/versions/${PAPERMC_VERSION}" | jq '.builds[-1]')
LATEST_DOWNLOAD=$(curl -s "https://papermc.io/api/v2/projects/paper/versions/${PAPERMC_VERSION}/builds/${LATEST_BUILD}" | jq '.downloads.application.name' -r)
echo -----------------
echo Paper version download: $PAPERMC_VERSION#$LATEST_BUILD
echo -----------------
PAPERMC_DOWNLOAD_URL="https://papermc.io/api/v2/projects/paper/versions/${PAPERMC_VERSION}/builds/${LATEST_BUILD}/downloads/${LATEST_DOWNLOAD}"
curl -s -o /opt/minecraft/paper.jar ${PAPERMC_DOWNLOAD_URL}
