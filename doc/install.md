# 使用環境
ruby : 2.4.1

rails : 5.0.6

mysql 5.7.19

# とりあえずやること
mysqlのインストール

ruby 2.4.1のインストール

bundlerのインストール

twitterからコンシューマキーを取得

databes.ymlの修正

secrtes.ymlの作成

modelの作成(DBを作成するため)

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
```

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

パスワードはかならず覚えておく

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

# MySQL. Versions 5.0 and up are supported.
#
# Install the MySQL driver
#   gem install mysql2
#
# Ensure the MySQL gem is defined in your Gemfile
#   gem 'mysql2'
#
# And be sure to use new-style password hashing:
#   http://dev.mysql.com/doc/refman/5.7/en/old-client.html
#
default: &default
  adapter: mysql2
  encoding: utf8mb4
  pool: 5
  username: 任意のユーザ名
  password: 任意のパスワード
  host: localhost

development:
  <<: *default
  database: beeinfo_development

# Warning: The database defined as "test" will be erased and
# re-generated from your development database when you run "rake".
# Do not set this db to the same as development or production.
test:
  <<: *default
  database: beeinfo_test

# As with config/secrets.yml, you never want to store sensitive information,
# like your database password, in your source code. If your source code is
# ever seen by anyone, they now have access to your database.
#
# Instead, provide the password as a unix environment variable when you boot
# the app. Read http://guides.rubyonrails.org/configuring.html#configuring-a-database
# for a full rundown on how to provide these environment variables in a
# production deployment.
#
# On Heroku and other platform providers, you may have a full connection URL
# available as an environment variable. For example:
#
#   DATABASE_URL="mysql2://myuser:mypass@localhost/somedatabase"
#
# You can use this database configuration with:
#
#   production:
#     url: <%= ENV['DATABASE_URL'] %>
#

# 定期実行用に使用するDBをデフォルトに設定

production:
  <<: *default
  database: beeinfo_development
  #database: beeinfo_production
  #username: beeinfo
  #password: <%= ENV['BEEINFO_DATABASE_PASSWORD'] %>

```

  ## データベースの作成

  ```
  $ rake db:create
  ```

  ## マイグレーションの実行

  ```
$ rake db:migrate
  ```

### rake db:migrateでエラーが出る場合
```
$ rake db:migrate
== 20171001140007 CreateTwitterData: migrating ================================
-- create_table(:twitter_data)
rake aborted!
StandardError: An error has occurred, all later migrations canceled:
~~~

```
以下を実行
```
$ bin/rails db:environment:set RAILS_ENV=development
$rake db:migrate:reset
```
その後もう一度以下を実行
```
$ rake db:migrate
```

## taskの実行

ツイートがDBに格納される。

基本的にはクローンで定期実行されるため使わない。
```
$ rails twitter:tweet
```

taskを実行しエラーが出る場合。

DBのテーブルの文字コードが「utf8mb4」でない場合エラーがでている可能性がある。

mysqlにログインする。

データベースの一覧を表示
```
# show databases;
```

使っているデータベースの変更
```
# use beeinfo_development
```

テーブルの状態を確認
```
# show create table twitter_data;
```

CHARSET=utf8mb4になってない場合
```
# alter table twitter_data convert to character set utf8mb4;
```
上記を実行

```
vim config/database.yml
encoding: utf8mb4
```
上記に変更

editsテーブルの文字コードがutd8mb4になってない場合は下記を実行

```
alter table edits convert to character set utf8mb4;  
```

## 定期実行の設定
定期実行したいものをconfig/schedule.rbに記述

現状は一定間隔でrake twitter:tweetをおこなう
```
$bundle exec whenever --update-crontab RAILS_ENV=develop
```

## twitterコンシューマーキーをtwitter.rakeから分離
(/Beeinfo/twitterOauth.txt)に移動

## デバッグ用にDB初期値を設定
rake db:reset //←DBのリセット
rake db:seed //←DB初期値をinsert

## サーバの起動
```
rails s
```
http://localhost:3000
