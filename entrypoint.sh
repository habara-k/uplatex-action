#!/bin/sh

set -e

warn() {
  echo "::warning :: $1"
}

error() {
  echo "::error :: $1"
  exit 1
}

target_file="$1"
working_directory="$2"

if [ -z "$target_file" ]; then
  error "Input 'target_file' is missing."
fi

if [ -n "$working_directory" ]; then
  cd "$working_directory"
fi

if [ ! -f "$target_file" ]; then
  error "File '$target_file' cannot be found from the directory '$PWD'."
fi

latexmk -e '$latex=uplatex; $pdf_mode=3; $dvipdf="dvipdfmx %O %S";' "$target_file"
