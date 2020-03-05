#!/bin/bash
~/Projects/mongodb-macos-x86_64-4.2.2/bin/mongodump -h $1 -d dashboarddb -o ~/Projects/hygieia-works/backup/$1/mongodump-`date +%Y-%m-%d`

