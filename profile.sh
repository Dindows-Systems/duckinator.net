#!/bin/bash

cd backend
ruby -rprofile backend.rb -e "h=Homepage.new('fairview_pier')(ENV.clone)"
