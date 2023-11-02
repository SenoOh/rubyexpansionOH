# Trigora
本システムは，研究室や介護施設でスマートホームシステムを運用することを想定し，スマートホームシステムの1つであるopenHABのデバイスの管理をサポートするインターフェースである．本システムを用いてopenHABのデバイス設定を担うテキストファイルを一括で作成，変更，削除することでスマートホームシステムを当該施設で運用する問題点であるデバイスの一括管理の問題を解決する．テキストファイルはスプレッドシートとテンプレートファイルを用いて作成する．

# Requirements
+ Ruby 3.x
+ Java 17.x
+ openHAB
  + https://www.openhab.org/

# Setup
## openHAB
### Linux
```
まず、openHAB リポジトリキーをパッケージマネージャーに追加する
$ curl -fsSL "https://openhab.jfrog.io/artifactory/api/gpg/key/public" | gpg --dearmor > openhab.gpg
$ sudo mkdir /usr/share/keyrings
既に存在している場合がある．
$ sudo mv openhab.gpg /usr/share/keyrings
$ sudo chmod u=rw,g=r,o=r /usr/share/keyrings/openhab.gpg
openHABが置いてあるリポジトリを追加する．
stable版
$ echo 'deb [signed-by=/usr/share/keyrings/openhab.gpg] https://openhab.jfrog.io/artifactory/openhab-linuxpkg stable main' | sudo tee /etc/apt/sources.list.d/openhab.list
test版
$ echo 'deb [signed-by=/usr/share/keyrings/openhab.gpg] https://openhab.jfrog.io/artifactory/openhab-linuxpkg testing main' | sudo tee /etc/apt/sources.list.d/openhab.list
apt のパッケージリストを更新後，openHABをインストール
$ sudo apt-get update
$ sudo apt-get install openhab
openHABのインストール完了後，下記コマンドを実行してopenHABを起動
$ sudo systemctl start openhab.service
$ sudo systemctl status openhab.service
$ sudo systemctl daemon-reload
$ sudo systemctl enable openhab.service
初回起動に約15分かかる
起動後，ブラウザ上で http://localhost:8080 を開くとpenHABの画面が開くので，各種初期設定を行う．
```

# Usage
## Settings
### 自動実行処理の設定
1. 
  ```

2. 
  ```

  ```

## Launch