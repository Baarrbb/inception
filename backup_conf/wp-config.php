<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the website, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/documentation/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress_db' );

/** Database username */
define( 'DB_USER', 'wordpress_user' );

/** Database password */
define( 'DB_PASSWORD', 'qwerty' );

/** Database hostname */
define( 'DB_HOST', 'mariadb' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8mb4' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         '_al,!PuLL}t`;qM/*%@a|s{*/@](U%z/ /@7x6J)Z}Y4p@21pN$?9!up5Ii/}Qo0' );
define( 'SECURE_AUTH_KEY',  'shc2P=G,Gh<7l&|x$[{3+%tag41pA`hFA;#X}mIKT1Gf6z%}{6#5keYJPt_>~@sK' );
define( 'LOGGED_IN_KEY',    '4(^(N~ef/[H=*~u2P=,6hDpV$<Z8j4HASG%Dm`DE=jb|>0#` J3dMeSn^,HZFi@W' );
define( 'NONCE_KEY',        'O~fv+9F%aG9r52_F2-m*X80ss_LR%$!i]ye.(D>jb<|356kaWpdj-a!io[|dYOLA' );
define( 'AUTH_SALT',        'u_xTmMY%*lScsdzm``e1Wb3jC2V52sw&8ppKZJC0_X]YWXA;wTGAQ#;vX001[T4S' );
define( 'SECURE_AUTH_SALT', '+]UlFMPY`k-y@tldnSK@1@K-HSDZ+=->wqId9^l,X+QJE~KWa*F7{Q3p^>=$bjQ>' );
define( 'LOGGED_IN_SALT',   ' SfcW]`}<&S_97/>@~E(:S0V|`.eT*@=`aex#u._)F%U^H>vAFNj!8@cKeFDTWS&' );
define( 'NONCE_SALT',       '$^eVyABg*CMg7HbUT=P~:fZbLF?#^yyAFB{X|k5SWcn+!+0[$yw],mz^tWEC&Kd`' );

/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/documentation/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* Add any custom values between this line and the "stop editing" line. */



/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
        define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';