#!/usr/bin/env bash

set -euo pipefail

build_jar() {

  local input="$1"
  local output="$2"

  if [ -f "$input" ]; then

    echo -e "\n'$input' -> '$output'"

    local indir="${input%/*}/"
    local outdir="${output%/*}/"

    mkdir -p "${outdir}classes/"

    javac -cp "java_packages/*" "${input/%Handler.java/*.java}" -d "${outdir}classes/"

    local args=("-C" "${outdir}classes/" "./")

    if [ -d "${indir}resources/" ]; then

      args+=("-C" "$indir" "resources/")
    fi

    jar cf "$output" "${args[@]}"

    rm -r "${outdir}classes/"
  fi
}
