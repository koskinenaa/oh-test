<?php
// a helper function to lookup "env_FILE", "env", then fallback
if (!function_exists('getenv_docker')) {
	// https://github.com/docker-library/wordpress/issues/588 (WP-CLI will load this file 2x)
	function getenv_docker($env, $default) {
		if ($fileEnv = getenv($env . '_FILE')) {
			return rtrim(file_get_contents($fileEnv), "\r\n");
		}
		else if (($val = getenv($env)) !== false) {
			return $val;
		}
		else {
			return $default;
		}
	}
}

/**
  * Database
  */
define( 'DB_NAME', getenv_docker('WORDPRESS_DB_NAME', 'wordpress') );
define( 'DB_USER', getenv_docker('WORDPRESS_DB_USER', 'example username') );
define( 'DB_PASSWORD', getenv_docker('WORDPRESS_DB_PASSWORD', 'example password') );
define( 'DB_HOST', getenv_docker('WORDPRESS_DB_HOST', 'mysql') );
define( 'DB_CHARSET', getenv_docker('WORDPRESS_DB_CHARSET', 'utf8') );
define( 'DB_COLLATE', getenv_docker('WORDPRESS_DB_COLLATE', '') );
define( 'MYSQL_CLIENT_FLAGS', MYSQLI_CLIENT_SSL );

$table_prefix = getenv_docker('WORDPRESS_TABLE_PREFIX', 'wp_');

/**
  * Authentication unique keys and salts.
  */
define( 'AUTH_KEY',         getenv_docker('WORDPRESS_AUTH_KEY',         'put your unique phrase here') );
define( 'SECURE_AUTH_KEY',  getenv_docker('WORDPRESS_SECURE_AUTH_KEY',  'put your unique phrase here') );
define( 'LOGGED_IN_KEY',    getenv_docker('WORDPRESS_LOGGED_IN_KEY',    'put your unique phrase here') );
define( 'NONCE_KEY',        getenv_docker('WORDPRESS_NONCE_KEY',        'put your unique phrase here') );
define( 'AUTH_SALT',        getenv_docker('WORDPRESS_AUTH_SALT',        'put your unique phrase here') );
define( 'SECURE_AUTH_SALT', getenv_docker('WORDPRESS_SECURE_AUTH_SALT', 'put your unique phrase here') );
define( 'LOGGED_IN_SALT',   getenv_docker('WORDPRESS_LOGGED_IN_SALT',   'put your unique phrase here') );
define( 'NONCE_SALT',       getenv_docker('WORDPRESS_NONCE_SALT',       'put your unique phrase here') );

/**
  * Debug
  */
define( 'WP_DEBUG', !!getenv_docker('WORDPRESS_DEBUG', '') );
define( 'WP_DEBUG_LOG', !!getenv_docker('WORDPRESS_DEBUG_LOG', '') );
define( 'WP_DEBUG_DISPLAY', !!getenv_docker('WORDPRESS_DEBUG_DISPLAY', '') );

/**
  * WordPress settings
  */
define( 'WP_MEMORY_LIMIT', getenv_docker('WORDPRESS_MEMORY_LIMIT', '256M') );

define( 'WP_POST_REVISIONS', getenv_docker('WORDPRESS_POST_REVISIONS', 5) );

define( 'DISALLOW_FILE_MODS', getenv_docker('WORDPRESS_DISALLOW_FILE_MODS', true) );

define( 'IMAGE_EDIT_OVERWRITE', getenv_docker('WORDPRESS_IMAGE_EDIT_OVERWRITE', true) );

define( 'WP_CRON_LOCK_TIMEOUT', getenv_docker('WORDPRESS_CRON_LOCK_TIMEOUT', 300) );
define( 'DISABLE_WP_CRON', getenv_docker('WORDPRESS_DISABLE_CRON', true) );

// If we're behind a proxy server and using HTTPS, we need to alert WordPress of that fact
// see also https://wordpress.org/support/article/administration-over-ssl/#using-a-reverse-proxy
// (we include this by default because reverse proxying is extremely common in container environments)
if (isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && strpos($_SERVER['HTTP_X_FORWARDED_PROTO'], 'https') !== false) {
	$_SERVER['HTTPS'] = 'on';
}

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
