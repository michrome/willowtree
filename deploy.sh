#!/bin/bash
ruby -v
gem env
ruby download_images.rb
middleman build
