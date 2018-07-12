#!/bin/bash
set -e

#
# Display settings on standard out.
#

USER="tautulli"

echo "Tautulli settings"
echo "================="
echo
echo "  User:       ${USER}"
echo "  UID:        ${TAUTULLI_UID:=666}"
echo "  GID:        ${TAUTULLI_GID:=666}"
echo
echo "  Config:     ${CONFIG:=/datadir/config.ini}"
echo

#
# Change UID / GID of Tautulli user.
#

printf "Updating UID / GID... "
[[ $(id -u ${USER}) == ${TAUTULLI_UID} ]] || usermod  -o -u ${TAUTULLI_UID} ${USER}
[[ $(id -g ${USER}) == ${TAUTULLI_GID} ]] || groupmod -o -g ${TAUTULLI_GID} ${USER}
echo "[DONE]"

#
# Set directory permissions.
#

printf "Set permissions... "
touch ${CONFIG}
chown -R ${USER}: /tautulli
chown ${USER}: /datadir $(dirname ${CONFIG}) ${CONFIG}
echo "[DONE]"

#
# Finally, start Tautulli.
#

echo "Starting Tautulli..."
exec su -pc "./Tautulli.py --nolaunch --datadir=$(dirname ${CONFIG}) --config=${CONFIG}" ${USER}
