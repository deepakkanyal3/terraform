find . -name "*.tf" -exec grep -E 'backend\s+"s3"' {} + |
  rev | cut -d'/' -f2- | rev |
  sort |
  uniq |
  while IFS= read -r d; do
    updated_string="${d%/*}"
    updated_string="${updated_string//\//_}"
    updated_string="${updated_string//./}"
    updated_string="${updated_string#_}"
    echo '[ {"dir": "'"$d"'", "workflow": "'"${updated_string}"'"} ]' | yq -rP
  done
