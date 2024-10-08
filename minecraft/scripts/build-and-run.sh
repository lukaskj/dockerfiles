#/bin/sh
cd /opt/minecraft

export MCVERSION="${VERSION:-1.19.3}"
export GOSUVERSION="${GOSU_VERSION:-1.17}"

export MEMORYSIZE="${MEMORY_SIZE:-1G}"

# Set Java Flags
export JAVAFLAGS=${JAVA_FLAGS:-"-Dlog4j2.formatMsgNoLookups=true -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=mcflags.emc.gs -Dcom.mojang.eula.agree=true"}

# Set PaperMC Flags
export PAPERMCFLAGS=${PAPERMC_FLAGS:-"--nojline"}

export PUID=${USER_ID:-1000}
export PGID=${GROUP_ID:-1000}


echo "#####################"
echo "# Updating packages #"
echo "#####################"
apt-get update && apt-get install -y curl jq wget

sh /opt/minecraft/scripts/install-gosu.sh ${GOSUVERSION}

FILE=/opt/minecraft/paper.jar
if [ ! -f "$FILE" ]; then
  echo "######################################"
  echo "# Installing Paper MC version $MCVERSION #"
  echo "######################################"

  sh /opt/minecraft/scripts/getpaperserver.sh ${MCVERSION}
fi

echo "####################"
echo "# Runing MC Server #"
echo "####################"
mkdir -p /data && cd /data
sh /opt/minecraft/scripts/docker-entrypoint.sh