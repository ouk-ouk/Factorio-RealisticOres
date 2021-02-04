#!/bin/bash

source_dir='./src/'
info_file="${source_dir}info.json"

cd "$(dirname "$0")"

mod_version="$(jq -cr '.version' "$info_file")"

git tag --annotate "$mod_version" --message="Version $mod_version"
