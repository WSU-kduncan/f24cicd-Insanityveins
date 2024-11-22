FROM node:18-bullseye

WORKDIR /usr/src/app
COPY ./wsu-hw-ng-main/ .

RUN npm install -g @angular/cli
RUN npm install

EXPOSE 4200

CMD [ "ng", "serve", "--host",  "0.0.0.0" ]
