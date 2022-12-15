#!/bin/bash

# ls -la /opt/app-root/src/vendor/wp-cli
# ls -la /opt/app-root/src/vendor
# bash /opt/app-root/src/vendor/wp-cli/wp-cli/bin/wp --version

./composer.phar config repositories.wpackagist composer https://wpackagist.org

./composer.phar config --json extra.installer-paths '{"wp-content/plugins/{$name}": ["type:wordpress-plugin"], "wp-content/mu-plugins/{$name}": ["type:wordpress-muplugin"], "wp-content/themes/{$name}": ["type:wordpress-theme"]}'

./composer.phar config --no-plugins allow-plugins.composer/installers true

# ./composer.phar require ${INSTALLABLE_PACKAGES}

cat ./composer.json

# ls -la

# ./composer.phar config --list

# kun wp-config.php ja tietokanta ovat asetettu
# bash wp plugin activate $(bash wp plugin list --status=inactive --field=name)
