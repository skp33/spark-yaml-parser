#!/usr/bin/env bash

if [[ -f $1 ]] >/dev/null 2>&1; then
  file=$1
else
  echo "Configuration file is not present " >&2
  exit 1
fi


yaml_parser() {
   local prefix=$2
   local s='[[:space:]]*' w='[a-zA-Z0-9_\-\.]*' fs=$(echo @|tr @ '\034'|tr -d '\015')
   sed -ne "s|^\($s\):|\1|" \
        -e "s|^\($s\)\($w\)$s:$s[\"']\(.*\)[\"']$s\$|\1$fs\2$fs\3|p" \
        -e "s|^\($s\)\($w\)$s:$s\(.*\)$s\$|\1$fs\2$fs\3|p"  $1 |
   awk -F$fs '{
      indent = length($1)/2;
      vname[indent] = $2;
      for (i in vname) {if (i > indent) {delete vname[i]}}
      if (length($3) > 0) {
         vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])(".")}
         printf("%s%s%s=%s", "'"$prefix"'",vn, $2, $3);
      }
   }'
}

echo $(yaml_parser $file " --conf ")

