#!/usr/bin/env sh

set -e

app_launcher="$HOME/.steam/steam/steamapps/common/Factorio/bin/x64/factorio"
mods_dir="$HOME/.factorio/mods/"
source_dir='./src/'
info_file="${source_dir}info.json"

help=0
install=0
run=0
if [ "$1" = '-h' ] || [ "$1" = '--help' ] ; then help=1 ; fi
if [ "$1" = '-i' ] || [ "$1" = '--install' ] ; then install=1 ; fi
if [ "$1" = '-t' ] || [ "$1" = '--test' ] ; then run=1 ; fi

if [ "$help" -eq 1 ]
then
	printf 'A simple script to build the mod (Linux only).\n'
	printf 'Usage:\t%s [OPTION]\n' "$(basename "$0")"
	printf 'Options:\n'
	printf '    -h, --help		- Show this help.\n'
	printf '    -i, --install	- Install the mod. (Move the zip to the mod dir.)\n'
	printf '    -t, --test		- Install the mod and run Factorio.\n'
	exit 0
fi

cd "$(dirname "$0")"

mod_name="$(jq -cr '.name' "$info_file")"
mod_version="$(jq -cr '.version' "$info_file")"
file_name="${mod_name}_${mod_version}"

cp -Rl "$source_dir" "./${file_name}"
zip -9 -r "./${file_name}.zip" "./${file_name}"
rm -rf "./${file_name}"

if [ "$install" -eq 1 ] || [ "$run" -eq 1 ]
then
	printf '\nInstalling "%s" in "%s".\n' "./${file_name}.zip" "$mods_dir"
	mv "./${file_name}.zip" "$mods_dir"
	if [ "$run" -eq 1 ]
	then
		printf '\nRunning "%s".\n' "$app_launcher"
		"$app_launcher"
	fi
fi
