FROM node:8-alpine

WORKDIR /screeps

RUN apk update; apk add python2 build-base

RUN yarn init -y

RUN yarn add screeps@3.4.3
RUN yarn add screepsmod-tickrate
RUN yarn add screepsmod-admin-utils


# Random token to make npx happy
RUN echo STEAM_TOKEN | npx screeps init

RUN rm -rf /screeps/mods.json
COPY mods.json /screeps/mods.json

RUN sed -e "s/password =/password = SCREEPS_PWD/" -i .screepsrc

FROM node:8-alpine

WORKDIR /screeps

COPY --from=0 /screeps /screeps

COPY "docker-entrypoint.sh" /
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 21025
EXPOSE 21026
VOLUME /screeps

CMD ["run"]
