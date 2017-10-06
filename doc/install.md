# ubuntu14.04

## gitのインストール

```
$ cd
$ sudo apt-get install git
```

## rbenvのインストール
```
$ git clone git;//github.com/sstephenson/rbenv.git .rbenv
$ echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile  
$ echo 'eval "$(rbenv init -)"' >> ~/.bash_profile  
$ source ~/.bash_profile
$ rbenv --version

```

## ruby 2.4.1インストール
```
rbenv install -l
rbenv install 2.4.1

```

## 下記のようなエラーが出る場合
```
rbenv install 2.4.1
Downloading ruby-2.4.1.tar.bz2...
-> https://cache.ruby-lang.org/pub/ruby/2.4/ruby-2.4.1.tar.bz2
Installing ruby-2.4.1...

BUILD FAILED (Ubuntu 14.04 using ruby-build 20170914-2-ge40cd1f)

Inspect or clean up the working tree at /tmp/ruby-build.20171006180021.31103
Results logged to /tmp/ruby-build.20171006180021.31103.log

Last 10 log lines:
The Ruby openssl extension was not compiled.
The Ruby readline extension was not compiled.
The Ruby zlib extension was not compiled.
ERROR: Ruby install aborted due to missing extensions
Try running `apt-get install -y libssl-dev libreadline-dev zlib1g-dev` to fetch missing dependencies.
~~~

以下を実行
```
$ sudo apt-get install -y libssl-dev libreadline-dev zlib1g-dev
```

## レポジトリのクローン
```
$ git clone https://github.com/kei-uma/Beeinfo.git
```
## bundlerのインストール
```
$ sudo apt-get install bundler
$ gem install bundler
```

## mysqlのインストール
```
$ sudo apt-get install mysql-server
```

rootのパスワード設定を設定する画面がでるのでパスワードを入力

かならず覚えておく

## bundleインストール

```
$ bundle install
```

エラーが出る場合

下記を実行
```
$ sudo apt-get install libmysqlclient-dev
```

mysql2でエラーが出る場合

```
$ vim Gemfile
gem mysql2をコメントアウト
```

## railsをインストール
```
$ gem install rails
```

### secretsファイルの作成
```
$ vim config/secrets.yml

development:
 secret_key_base: aaa #適当

test:
 secret_key_base:  3e #適当

production:
 secret_key_base:  <%= ENV["SECRET_KEY_BASE"] %>
```

## railsアプリのデータベースの設定
```
$ vim config/database.yml
#

default: &default
  adapter: mysql2
  encoding: utf8mb4
  pool: 5
  username: 変更
  password: 変更
  host: localhost


```

## データベースの作成
```
$ rake db:create
```
