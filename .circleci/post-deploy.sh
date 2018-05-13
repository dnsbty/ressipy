#!/bin/bash

ssh $APP_USER@$APP_HOST <<ENDSSH
  echo "changing dir to ./apps/$APP_NAME";
  cd ./apps/$APP_NAME;

  echo "stopping app";
  ./bin/$APP_NAME stop;

  echo "starting app";
  ./bin/$APP_NAME start;

  echo "Finished";
ENDSSH
