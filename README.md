# 1hour-rec-server(1時間で作れる自宅録画サーバー)

[Simple Life氏によるオリジナル](https://www.digital-den.jp/simplelife/archives/8014)

上記ブログ記事を元に、PLEXチューナー+mirakurun+EPGStationをDocker Composeで動かせるようにしたシェルスクリプト群です。

録画の動作確認がとれた後に、下記のコマンドでシンボリックリンクを張り直してください。

```bash
cd ~/git/docker-mirakurun-epgstation
docker compose down
mv recorded recorded.org
ln -s /mnt/path-to/recorded recorded
docker compose up -d
```
