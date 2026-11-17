#!/bin/bash
BACKUP_ROOT="$(pwd)"

BACKUP_DIR="$BACKUP_ROOT/$(date +%Y%m%d)"
mkdir -p "$BACKUP_DIR"

cd "$HOME/git/docker-mirakc-epgstation"

# 1. MariaDB ホットバックアップ
docker compose exec mysql sh -c 'exec mariadb-dump -uroot -p"$MYSQL_ROOT_PASSWORD" --databases epgstation' | gzip > $BACKUP_DIR/epgstation-mariadb.sql.gz

# 2. mirakc設定ファイルバックアップ
sudo tar -cjvf $BACKUP_DIR/mirakc_config.tar.bz2 "mirakc/" 

# 3. EPGStation設定ファイルバックアップ
sudo tar -cjvf $BACKUP_DIR/epgstation_config.tar.bz2 "epgstation/"

# 7日以上前の古いバックアップを削除
find "$BACKUP_ROOT" -mindepth 1 -maxdepth 1 -type d -mtime +7 -exec rm -rf {} +

sudo chown -R $(id -u):$(id -g) "$BACKUP_DIR"