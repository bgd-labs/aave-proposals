#!/bin/bash

git diff --no-index --ignore-space-at-eol $1 $2 > reports/$3.md
sed -i '1s/^/```/' reports/$3.md
