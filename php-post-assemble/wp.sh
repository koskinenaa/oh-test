#!/bin/bash

# ls -la /opt/app-root/src/vendor/wp-cli
# ls -la /opt/app-root/src/vendor
# bash /opt/app-root/src/vendor/wp-cli/wp-cli/bin/wp --version

# ./composer.phar require ${INSTALLABLE_PACKAGES}

# kun wp-config.php ja tietokanta ovat asetettu
WP_CLI='/opt/app-root/src/vendor/wp-cli/wp-cli/bin/wp'
bash ${WP_CLI} db create

INSTALLED_PLUGINS=$(bash ${WP_CLI} plugin list --status=inactive --field=name)
bash ${WP_CLI} plugin activate "${INSTALLED_PLUGINS}"
