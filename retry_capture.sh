#!/usr/bin/env bash

cd $(dirname "$0")
. config.sh

while ! timeout -k 3s --foreground 2s ./capture.sh -vframes 10 $*; do 
    date
done