#!/usr/bin/env sh

build_type="release"
options="-warnings-as-errors"
case "$1" in
	-d|--debug)
		build_type="debug"
		options="$options -debug"
		;;
esac

mkdir -p "build/$build_type/"
odin build "src/" -out:"build/$build_type/mouse" $options
