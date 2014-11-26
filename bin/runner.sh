#!/bin/sh

filewatcher  "*.{rb,py,js}" 'ruby tddwatcher.rb $FILENAME'


