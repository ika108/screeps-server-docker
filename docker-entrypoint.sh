#!/bin/sh
set -e

function run_srv(){
  echo "-- Starting main server --"
  cd /screeps
  sed -e "s/STEAM_TOKEN/${STEAM_TOKEN}/" -i .screepsrc
  sed -e "s/password = SCREEPS_PWD/password = ${SCREEPS_PWD}/" -i .screepsrc
  echo "-- Starting npx --"
  npx screeps start & sleep 5
  echo "-- Setting tick_rate to ${TICK_RATE} --"
  echo -n "setTickRate($TICK_RATE);" | nc localhost 21026
  echo -n "map.updateTerrainData();" | nc localhost 21026
  echo "-- Tailing logs to console --"
  tail -f /screeps/logs/*.log
  echo "-- end of func run_srv() --"
}

function init_srv(){
  echo "-- Initialising everything --"
  cd /screeps
  sed -e "s/STEAM_TOKEN/${STEAM_TOKEN}/" -i .screepsrc
  sed -e "s/password = SCREEPS_PWD/password = ${SCREEPS_PWD}/" -i .screepsrc
  npx screeps start & sleep 5
  echo -n "system.resetAllData();" | nc localhost 21026
  echo -n "setTickRate($TICK_RATE);" | nc localhost 21026
  echo -n "map.updateTerrainData();" | nc localhost 21026
  killall node
  echo "-- End of initialisation --"
}

CONTAINER_ALREADY_STARTED="CONTAINER_ALREADY_STARTED_PLACEHOLDER"
if [ ! -e /screeps/$CONTAINER_ALREADY_STARTED ]; then
    touch /screeps/$CONTAINER_ALREADY_STARTED
    echo "-- First container startup --"
    init_srv
else
    echo "-- Already inited --"
fi

case $1 in
  run)
    run_srv
    ;;
  init)
    init_srv
    ;;
  *)
    exec "$@"
    ;;
esac
