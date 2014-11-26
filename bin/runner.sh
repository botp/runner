#!/bin/sh

filewatcher  "*.{rb,py,js}" 'ruby $RUNNER_ROOT/bin/tddwatcher.rb $FILENAME'


