#!/bin/bash
BACKUP_DIR="$1"
cd "$BACKUP_DIR"
BACKUP_DIR_ABS=$(pwd)

cd "$HOME/git/docker-mirakurun-epgstation"
DOCKER_ROOT=$(pwd)

# 1. MariaDB ホットレストア
# 起動後、ダンプを復元する
docker compose down
docker volume rm docker-mirakurun-epgstation_mysql-db
docker compose up -d mysql

# MariaDBが接続可能になるまで待機（ここが重要）
echo "Waiting for MariaDB to be ready..."
until docker exec mysql-epgstation-v3 sh -c 'exec mariadb-admin ping -uroot -p"$MYSQL_ROOT_PASSWORD" --silent'; do
  sleep 2
done
sleep 3

echo "Restoring database..."
zcat $BACKUP_DIR_ABS/epgstation-mariadb.sql.gz | docker compose exec -T mysql sh -c 'exec mariadb -uroot -p"$MYSQL_ROOT_PASSWORD"'
echo "Restore completed!"

# 2. Mirakurun設定ファイルレストア
sudo rm -rf  "$DOCKER_ROOT/Mirakurun/data" "$DOCKER_ROOT/Mirakurun/config"
sudo tar -xjvf $BACKUP_DIR_ABS/mirakurun_config.tar.bz2

# 3. EPGStation設定ファイルレストア
sudo rm -rf "$DOCKER_ROOT/epgstation"
sudo tar -xjvf $BACKUP_DIR_ABS/epgstation_config.tar.bz2

# 残りのコンテナを起動する
docker compose up -d
