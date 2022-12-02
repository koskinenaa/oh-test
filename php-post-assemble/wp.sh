#!/bin/bash

bash vendor/wp-cli/wp-cli/bin/wp --version

# kun wp-config.php ja tietokanta ovat asetettu
# bash vendor/wp-cli/wp-cli/bin/wp plugin activate $(bash vendor/wp-cli/wp-cli/bin/wp plugin list --status=inactive --field=name)
