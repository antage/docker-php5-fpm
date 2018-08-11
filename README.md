# php5-fpm

PHP-FPM 5.x

Based on debian:jessie.

## Building

Just run `make`.

## Volumes

* `/var/lib/php5/sessions` (tmpfs is recommended)
* `/var/log/php5-fpm`
* `/var/www`

## Exposed ports

* 9000/tcp

## Environment variables

* `CREATE_USER_UID`
* `CREATE_USER_GID`
* `CREATE_SYMLINKS` (for example: "/var/www/dir1>/var/dir1,/var/www/dir2>/var/dir2")
* `PHP_FPM_RUN_USER` (www-data by default)
* `PHP_FPM_RUN_GROUP` (www-data by default)
* `PHP_FPM_MAX_WORKERS` (32 by default)
* `PHP_FPM_MAX_REQUEST` (1024 by default)
* `PHP_FPM_COREDUMP` (empty by default)
* `PHP_MODS`
* `PHP_TIMEZONE` ('UTC' by default)
* `PHP_SMTP` - MTA SMTP IP-address/hostname
* `PHP_SMTP_FROM` - default `From` header for mail.
* `PHP_MBSTRING_FUNC_OVERLOAD` - `mbstring.func_overload` (0 by default).
* `PHP_NEWRELIC_LICENSE_KEY` - Newrelic agent license key (empty and disabled by default).
* `PHP_NEWRELIC_APPNAME` - Newrelic application name (empty by default).
* `PHP_NEWRELIC_FRAMEWORK` - Newrelic framework name ('no_framework' by default).
* `PHP_NEWRELIC_PORT` - newrelic-daemon socket path or port number ('/run/newrelic/newrelic.sock' by default).

## Required variables

Following variables must be defined to run the container:

* `PHP_SMTP`
* `PHP_SMTP_FROM`
