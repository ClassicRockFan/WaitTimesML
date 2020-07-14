#!/bin/bash

export NODE_ENV=production
DEBUG_DIR=./logs/
DEBUG_FILE=$(date +%s).log

mkdir -p $DEBUG_DIR
node ./server.js >> $DEBUG_DIR/$DEBUG_FILE
