FROM --platform=linux/arm64 node:20.14.0-alpine3.20

ARG NODE_ENV=development
ENV NODE_ENV $NODE_ENV

# install global packages
ENV NPM_CONFIG_PREFIX=/home/node/.npm-global
ENV PATH /home/node/.npm-global/bin:$PATH
RUN npm i --unsafe-perm --allow-root -g npm@latest expo-cli@latest

RUN mkdir /opt/app
WORKDIR /opt/app
ENV PATH /opt/app/.bin:$PATH
COPY ./package.json ./package-lock.json /opt/app/
RUN npm install

# for development, we bind mount volumes; comment out for production
COPY . /opt/app

CMD ["npm", "run", "web"]
