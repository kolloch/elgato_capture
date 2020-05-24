#!/usr/bin/env bash

while ! timeout -k 3s --foreground 2s ./capture.sh -vframes 10; do 
    date
done