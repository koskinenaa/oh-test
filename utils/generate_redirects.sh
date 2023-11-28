#!/bin/bash

output=$1

if [ -z "$WORDPRESS_REDIRECTS" ]; then
  echo "No WORDPRESS_REDIRECTS found!"
  exit 1
fi

# Clean any existing redirects
rm $output

echo "RewriteEngine On" >> $1
echo "SSLProxyEngine on" >> $1
echo "# --- Generated Redirects --- " >> $1

readarray -t redirects < <(echo $WORDPRESS_REDIRECTS | jq -c '.redirects[]')

for i in "${redirects[@]}"; do
  source_url=$(echo "$i" | jq -rc '.from')
  target_url=$(echo "$i" | jq -rc '.to')

  # Check if the URL contains both host and path
  if [[ $source_url =~ ^https?://([^/]+)/(.+)$ ]]; then
      source_host="${BASH_REMATCH[1]}"
      source_path="/${BASH_REMATCH[2]}"
  else
      source_path=$source_url
  fi

  # Add rewrite condition if source url contains host
  if [ -n "$source_host" ]; then
    echo "RewriteCond %{HTTP_HOST} ${source_host//\"} [NC]" >> $1
  fi

  echo "RewriteRule ^${source_path//\"}\$ $target_url [R=302,L]" >> $1

  unset source_url
  unset source_host
  unset source_path
  unset target_url
done
