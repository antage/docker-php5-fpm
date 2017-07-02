#!/bin/bash
set -e

if [ "$CREATE_USER_UID" -a "$CREATE_USER_GID" ]; then
    echo "Create 'site-owner' group with GID=$CREATE_USER_GID"
    groupadd -g $CREATE_USER_GID site-owner
    echo "Add 'www-data' user to group 'site-owner'"
    usermod -a -G site-owner www-data
    echo "Create 'site-owner' user with UID=$CREATE_USER_UID, GID=$CREATE_USER_GID"
    useradd -d /var/www -g $CREATE_USER_GID -s /bin/false -M -N -u $CREATE_USER_UID site-owner
fi

if [ -n "$CREATE_SYMLINKS" ]; then
    for link in ${CREATE_SYMLINKS//,/ }; do
        TARGET=${link%>*}
        TARGET_DIR=${TARGET%/*}
        FROM=${link#*>}
        echo "Creating symlink from '${FROM}' to '${TARGET}'"
        if [ ! -d $TARGET_DIR ]; then
            echo -e "\tcreating directory '${TARGET_DIR}'"
            mkdir -p $TARGET_DIR
        fi
        ln -sf $FROM $TARGET
    done
fi

export PHP_TIMEZONE="${PHP_TIMEZONE:-UTC}"
for mod in $(echo $PHP_MODS | tr ',' ' '); do
    echo "Enabling PHP 5.x module '$mod'."
    php5enmod -s ALL $mod
done

if [ -n "$PHP_NEWRELIC_LICENSE_KEY" -a -n "$PHP_NEWRELIC_APPNAME" ]; then
    php5enmod -s fpm newrelic
fi

echo "Updating PHP configuration files."
/usr/local/bin/confd -onetime -backend env

if [ "$1" = 'php5-fpm' ]; then
    echo "Starting PHP-FPM in foreground."
    exec /usr/sbin/php5-fpm
fi

exec "$@"
