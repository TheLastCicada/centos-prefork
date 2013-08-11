<?php
/**
 * The base configurations of the WordPress.
 *
 * This file has the following configurations: MySQL settings, Table Prefix,
 * Secret Keys, WordPress Language, and ABSPATH. You can find more information
 * by visiting {@link http://codex.wordpress.org/Editing_wp-config.php Editing
 * wp-config.php} Codex page. You can get the MySQL settings from your web host.
 *
 * This file is used by the wp-config.php creation script during the
 * installation. You don't have to use the web site, you can just copy this file
 * to "wp-config.php" and fill in the values.
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define('DB_NAME', 'prefork');

/** MySQL database username */
define('DB_USER', 'wp');

/** MySQL database password */
define('DB_PASSWORD', 'wp');

/** MySQL hostname */
define('DB_HOST', 'localhost');

/** Database Charset to use in creating database tables. */
define('DB_CHARSET', 'utf8');

/** The Database Collate type. Don't change this if in doubt. */
define('DB_COLLATE', '');

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         '&-YpIB$z2B.|EPykJrj5 ZEuu{+++ELV]EM3LgtOvWyZ;7*-d>d{:<*HjOENaqX*');
define('SECURE_AUTH_KEY',  '<*]K*3BrW+<EX*sdUxxkl4{jNE,8qXZ&p|SU6<HjlbN#gR5{*t|vTL!E=v<&=jo[');
define('LOGGED_IN_KEY',    'WLD5;f?&~V 6FHb}IM>Hx;))=rG*z,Yaz3N[etAtQ,;J*H*+,j3y-JU ,?<vuH;1');
define('NONCE_KEY',        '_<uuT!85R[ .|.XcyXA-& 366$/Ahd*MM6gkh>s)%)Hm.fT8 !Jc^c|fLxH2p9}}');
define('AUTH_SALT',        'xkq^{9Bz_eki8W`0|{8Q(8S+M7?t!<%Q!ruUgR:M_Mc[2/6S~U$;*[u>OP-;^/.e');
define('SECURE_AUTH_SALT', '1~HrY_!-<:fYkoYZ0Pfoi/:c75dFF@3K|p(m[-=5PJ:g49a7V/#~L wU9d0eSzrI');
define('LOGGED_IN_SALT',   'US}8xm|A_^Zr$<+xhP,Eg%Wf,A>+-`j`yI9T{ggk-*~n>L%J6/EFJ:>5UyNw)w4D');
define('NONCE_SALT',       'Hn+@_3^%z/+As<t~qLY<X wJ3=G|O=TE.4b~Sf-= kXhkn5:o/sNo_I`q9HC0xIi');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each a unique
 * prefix. Only numbers, letters, and underscores please!
 */
$table_prefix  = 'wp_';

/**
 * WordPress Localized Language, defaults to English.
 *
 * Change this to localize WordPress. A corresponding MO file for the chosen
 * language must be installed to wp-content/languages. For example, install
 * de_DE.mo to wp-content/languages and set WPLANG to 'de_DE' to enable German
 * language support.
 */
define('WPLANG', '');

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 */
define('WP_DEBUG', false);

/* That's all, stop editing! Happy blogging. */

/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');