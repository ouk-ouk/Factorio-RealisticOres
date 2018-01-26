#!/bin/bash

source_dir='./src/'
info_file="${source_dir}info.json"

cd "$(dirname "$0")"

mod_name="$(jq -cr '.name' "$info_file")"
mod_version="$(jq -cr '.version' "$info_file")"
file_name="${mod_name}_${mod_version}"

cp -R "$source_dir" "./${file_name}"
zip -9 -r "./${file_name}.zip" "./${file_name}"
rm -rf "./${file_name}"
