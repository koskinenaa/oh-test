# Prereq
On host, export environment variable COMPOSER_AUTH with these details:

    '{"github-oauth": {"github.com": "your_github_pat"}}'


# Docker build example
    docker build --secret id=COMPOSER_AUTH -t openshift-base-secret-image-t wp-helsinki-base .

# Docker build example, repositories and packages provided as build args
    docker build \
    --secret id=COMPOSER_AUTH \
    --build-arg COMPOSER_REPOSITORIES="wordpress-helfi-helsinkiteema vcs https://github.com/City-of-Helsinki/wordpress-helfi-helsinkiteema | wordpress-helfi-site-core vcs https://github.com/City-of-Helsinki/wordpress-helfi-site-core" \
    --build-arg COMPOSER_PACKAGES="city-of-helsinki/wordpress-helfi-helsinkiteema city-of-helsinki/wordpress-helfi-site-core" \
    -t wp-helsinki-base.

Repository format: repo_name type url (separated with "|" pipe character)