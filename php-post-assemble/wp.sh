#!/bin/bash

ls -la /opt/app-root/src/vendor/wp-cli
ls -la /opt/app-root/src/vendor
# bash /opt/app-root/src/vendor/wp-cli/wp-cli/bin/wp --version

# kun wp-config.php ja tietokanta ovat asetettu
# bash wp plugin activate $(bash wp plugin list --status=inactive --field=name)
