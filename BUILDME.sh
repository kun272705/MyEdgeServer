#!/usr/bin/env bash

set -euo pipefail

source .builder.sh

mvn dependency:copy-dependencies -DoutputDirectory=java_packages/ -DincludeScope=test

mvn dependency:copy-dependencies -DoutputDirectory=tgt/lib/ -DincludeScope=runtime

for dir in src/pub/*/; do
 
  item="${dir/src/tgt}"
  item="${item//.//}"
  item="${item%/}"

  if [ -f "${dir}Handler.java" ]; then

    build_jar "${dir}Handler.java" "${item}.jar"
  fi
done

echo -e "\nDone"
