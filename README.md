# 1hour-rec-server(1時間で作れる自宅録画サーバー)

## mirakc+miraview+VAAPI有効仕様

- [Simple Life氏によるオリジナル](https://www.digital-den.jp/simplelife/archives/8014)
- [DockerFile内JoinLogoScpTrialSetLinux周りのビルド参考記事](https://note.com/leal_walrus5520/n/n7181f4b46d5f)

上記ブログ記事を元に、PLEXチューナー+mirakc+miraview+EPGStationをDocker Composeで動かせるようにしたシェルスクリプト群です。

録画の動作確認がとれた後に、下記のコマンドでシンボリックリンクを張り直してください。

```bash
cd ~/git/docker-mirakc-epgstation
docker compose down
mv recorded recorded.org
ln -s /mnt/path-to/recorded recorded
docker compose up -d
```
