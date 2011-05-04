#!/bin/bash

cd backend
PATH_INFO="/" ruby -r./backend.rb -e "h=HomePage.new('fairview_pier'); r=h.call(ENV.clone); puts r[2][0]"
