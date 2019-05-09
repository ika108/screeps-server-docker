# screeps-server-docker
This a Docker image for a stand-alone Screeps server 3.4.3.


[![Screeps logo](https://github.com/screeps/screeps/raw/master/logo.png "Screeps logo")](https://screeps.com/)

# Start the server
`docker run -ti --name screeps-server -d -e STEAM_TOKEN=XXXXXXXXX -e SCREEPS_PWD=YYYYYYYY -e TICK_RATE=1000 ika108/screeps-server-standalone run`

## Access logs
`docker logs -f screeps-server`

## Access game console
`docker exec -ti -w /screeps screeps-server npx screeps cli`

## Exposed ports :
- 21025/tcp : Game port
- 21026/tcp : Console port

**Don't expose your Console port directly!!**

**The console protocol is clear text with no auth. Consider adding a reverse-proxy**

## Volumes :
- /screeps

## Variables :
- STEAM_TOKEN : Get yours at [Steam](https://steamcommunity.com/dev/managegameservers)
- SCREEPS_PWD : Your server access password. (empty by default)
- TICK_RATE : Interval between each game tick in ms. (see : [screepsmod-tickrate](https://github.com/ScreepsMods/screepsmod-tickrate))

## Todo :
- Add methods to secure the server connection
- Add useful console commands
- Add methods to reset the server state
