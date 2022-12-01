#!/bin/bash

bash vendor/wp-cli/wp-cli/bin/wp --version

bash vendor/wp-cli/wp-cli/bin/wp plugin activate $(bash vendor/wp-cli/wp-cli/bin/wp plugin list --status=inactive --field=name)
