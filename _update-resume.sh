#!/usr/bin/env bash

wget https://github.com/duckinator/resume/raw/master/public/resume.pdf || { echo "Could not fetch resume." && exit 1; }
