#!/bin/bash
set -e

pg_ctl -D "$PGDATA" -m fast -w stop
rm -rf "$PGDATA"/*
PGPASSWORD=replicator_password pg_basebackup -h postgres-master -D "$PGDATA" -U replicator -P -S physical_slot -X stream -R
pg_ctl -D "$PGDATA" -o "-c config_file=/etc/postgresql/postgresql.conf" -w start