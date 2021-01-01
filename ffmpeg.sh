#!/usr/bin/env bash

#ffmpeg -i input.mp3 -metadata artist="Someone" -f mp3 output.mp3

function filename_remove_percent() {
#
# Convert percentages found in filename to ascii equivalent
# eg:  %20 needs to be converted into a space character
#
for file_old in *.mp3 ; do
	file_new=$(echo ${file_old} | sed 's/%20/ /g' )

	mv -v "${file_old}" "${file_new}"
done
}

function metadata_add() {
#
# List all metadata tags that are to be globally updated
#
	metadata='-metadata artist="Usher" '
        metadata+='-metadata account_id= '
}

metadata_add ; # Setup mp3 metadata tags

#
# Multi-thread the ffmpeg processing of each MP3 track.
#
for file in *.mp3 ; do
	ffmpeg -loglevel panic -i "${file}" ${metadata} -f mp3 "output_${file}" &
done
