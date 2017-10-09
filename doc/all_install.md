# まっさらなUbuntu14.04からBeeinfoをビルドする
## Ubuntuのインストール
下記ページの日本語Remix仮想ハードディスクイメージのダウンロード  
\*好きなディレクトリで構いません  
<https://www.ubuntulinux.jp/download>  

ダウンロードされたubuntu-ja-14.04-desktop-amd64-vhd.zipを解凍  

\*zipファイルの解凍に失敗する場合はコマンドで解凍  
 
上記ファイルの解凍が完了したらVirtualBoxを起動  

\*BirtualBoxのインストール手順は省略  

新規→名前を入力(何でも可)/タイプはLinux/バージョンはUbuntu(64bit)を選択  

→メモリサイズは768MB以上であれば適当な値で可  

→すでにある仮想ハードディスクファイルを使用するを選択し、先ほどダウンロード・解凍したUbuntuを指定  

→起動  
 
## Rubyのインストール
下記README.mdを参考にRuby,rbenvをインストール  
<https://github.com/YoshitakaKido/Beeinfo>  

\*Ruby on Railsのインストールはまだしなくてもよい  

\*gitのインストールをしていないのでgit cloneをする前にgitをインストールする
```
$sudo apt-get install git  //←git cloneする前に実行
$git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
```
\*rbenv install 2.4.1を実行する前にインストール
```
$sudo apt-get install -y libssl-dev libreadline-dev zlib1g-dev //←追加
$rbenv install 2.4.1
```
## Beeinfoのビルド
### 必要なパッケージをインストール
```
$sudo apt-get install mysql-server
$sudo apt-get install libmysqld-dev
$sudo apt-get install bundler
$sudo apt-get install ruby-railties-4.0
```
### Beeinfoレポジトリのクローン
```
$git clone https://github.com/kei-uma/Beeinfo.git
```
### gemパッケージのインストール
    $cd Beeinfo //Gemfile.lockが存在するディレクトリを移動
    $gem install bundler 
    $bundle install  //Gemfileに記述されているパッケージを一括インストール
    $gem install rails //いらないかもしれない
 
### 設定ファイルの修正
viエディタの使い方が分からない→下記サイトを参照  
<http://www.gi.ce.t.kyoto-u.ac.jp/user/susaki/command/vi.html>  
 
#### secrets.ymlを編集
```
$vi config/secrets.yml
 
/*ymlファイルの書き方を参照. “:”の後はスペースを空ける. 行頭はタブでなくスペース.
development:
 secret_key_base: aaa //aaaは適当
 
test:
 secret_key_base: 3e //3eは適当

production:
 secret_key_base: <%= ENV["SECRET_KEY_BASE"] %>
```
#### database.ymlを編集
```
$vi config/database.yml
 
default: &default
 adapter: mysql2
 encoding: utf8mb4
 pool: 5
 username: user-name //後述のmysqlで作成したuser-nameを使用
 password: pass //後述のmysqlで作成したpassを使用
 host: localhost
 
development:
 <<: *default
 database: Beeinfo
```
### mysqlの諸操作
    $mysql -u root -p //mysqlのrootでログイン
    >create user ‘user-name’@localhost identified by ‘pass’; //先述のdatabase.ymlと同じものにする
    >create database Beeinfo; //Beeinfoのデータベースを作成
    >grant all privileges on Beeinfo.* to ‘user-name’@‘localhost’; //user-nameに権限を付与
 
### .bashsrcに追記
    $cd //ホームディレクトリに移動
    $echo 'export RAILS_ENV=development' >> .bashsrc
    $cd - //元のディレクトリに移動
 
### データベースの作成
    $rake db:create
 
### modelの設定
    $rails generate model TwitterDatum trend:string tweet:text
    $rails generate scaffold edit user:string title:string date:date category:string text:text url:string
    $rake db:migrate
 
### taskの作成
    $mv lib/tasks/twitter.rake.sample.rake lib/tasks/twitter.rake //sampleファイルをリネーム
    $gedit lib/tasks/twitter.rake //viでも構わない, twitterOauthの認証キーを4つ入力
 
 ### データベースの文字コードの変更
    $mysql -u root -p
    >use Beeinfo
    >alter table twitter_data convert to character set utf8mb4;
    >alter table edits convert to character set utf8mb4;
 
### taskの実行
    $rails twitter:tweet
    
### サーバの起動
```
$rails s //ローカルでWebサーバを起動, 以後サービスを確認するときはこのコマンドを打つ
```
 
### サービスを確認する
<http://localhost:3000>
