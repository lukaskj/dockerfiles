#/bin/sh
echo "ASDASDASDASD"
cd /opt/minecraft

export MCVERSION="${VERSION:-1.19.3}"
export GOSUVERSION="${GOSU_VERSION:-1.16}"

export MEMORYSIZE="${MEMORY_SIZE:-1G}"

# Set Java Flags
export JAVAFLAGS=${JAVA_FLAGS:-"-Dlog4j2.formatMsgNoLookups=true -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=mcflags.emc.gs -Dcom.mojang.eula.agree=true"}

# Set PaperMC Flags
export PAPERMCFLAGS=${PAPERMC_FLAGS:-"--nojline"}


echo "##########################"
echo "# Update alpine packages #"
echo "##########################"
apk update && apk upgrade --available && sync && apk add curl jq wget


echo "################"
echo "# Install gosu #"
echo "################"
wget -q -O /usr/local/bin/gosu https://github.com/tianon/gosu/releases/download/$GOSUVERSION/gosu-amd64
chmod +x /usr/local/bin/gosu
echo Done!
echo

echo "####################"
echo "# Install Paper MC #"
echo "####################"
sh /opt/minecraft/scripts/getpaperserver.sh ${MCVERSION}


echo "################"
echo "# Run Paper MC #"
echo "################"
mkdir -p /data && cd /data
sh /opt/minecraft/scripts/docker-entrypoint.sh