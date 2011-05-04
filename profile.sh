#!/bin/bash

cd backend
PATH_INFO="/" ruby -rprofile backend.rb -e "h=Homepage.new('fairview_pier')(ENV.clone)"
