FROM registry.access.redhat.com/ubi9/php-81:1-25

ENV PATH='/opt/app-root/src/bin:/opt/app-root/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/app-root/src/vendor/bin'
ENV AZURE_SQL_SSL_CA_PATH='/usr/local/share/ca-certificates/DigiCertGlobalRootCA.crt.pem'

ENV DISPLAY_ERRORS=OFF

USER 0

# CA cert for MySQL Database
RUN mkdir -p /usr/local/share/ca-certificates && \
    wget https://dl.cacerts.digicert.com/DigiCertGlobalRootCA.crt.pem -O $AZURE_SQL_SSL_CA_PATH

# MySql and Helm repository
RUN dnf install -y https://dev.mysql.com/get/mysql80-community-release-el9-1.noarch.rpm

# MySql install
RUN dnf install -y mysql-community-client

# Install WP-CLI
RUN curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x /usr/local/bin/wp

ADD . /tmp/src/

# Set permissions for s2i scripts
RUN chmod +x /tmp/src/.s2i/bin/assemble-wrapped /tmp/src/.s2i/bin/run-wrapped

# Install the dependencies
RUN /tmp/src/.s2i/bin/assemble-wrapped

# Set the default command for the resulting image
CMD /opt/app-root/src/.s2i/bin/run-wrapped
