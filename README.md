#  クローンを動かす方法

doc/install.mdを参照

# 使用環境
ruby : 2.4.1

rails : 5.0.6

mysql 5.7.19

## railsのバージョン変更
```
 $ rails -v
 $ gem uninstall rails
```

## railsのバージョンが切り替わらない場合

railtiesのアンインストールが必要

```
 $ gem uninsrall railties
 $ gem insall rails -v '○.○.○'
```

 # mysqlの設定

 ## mysqlのインストール

 mysqlをインストール際にパスワードを入力するので必ず覚えておく!!

 mysqlにrootでログイン
 ```
 $ mysql -u root -p
 ````

 ユーザ一覧を表示
 ```
 $ SELECT User, Host FROM mysql.user;
 ```

 ## アカウント作成
 ```
 create user 'ユーザ名'@localhost identified by 'パスワード';
 ```
 ## memo
 ```
 $ SET GLOBAL validate_password_length=4;
 $ show variables like 'validate_password%';
 $ create user 'root'@localhost identified by 'root';
 ```
 ユーザを消去
 ```
 $ drop user 'ユーザ名'@'localhost';
 ```

# railsアプリの作成

## mysqlでアプリの作成

アプリを作成する時、DBをmysqlに変更

```
$ rails new beeinfo -d mysql
$ cd beeinfo
```

 bin/rake: spring inserted

 bin/rails: spring inserted

 ## Gemfileの編集
 ```Gemfile
 $ vim Gemfile
 gem 'therubyracer', platforms: :ruby	←コメントを外す
 ```


# 追加
 ```
 gem "twitter"
 gem 'oauth'
 gem 'json'
 gem 'whenever', require: false
 ```

 ## Bundleのインストール
 ```
 $ bundle install
 ```

## データベースの作成
 ```
 $ rake db:create
 ```

ここでエラーが出る場合

 ```ruby:database.yml
$ vim config/database.yml
（usernameとpasswordを入力する）。

default: &default
adapter: mysql2
encoding: utf8mb4  #最初はutf8ですがdbにツイートを追加する際にエラーがでるので後で変更します。
pool: 5
username: ここに追加
password: ここに追加
socket: /var/run/mysqld/mysqld.sock
```

## mysqlの起動
```
$ mysql.server start
```
上記でもエラーが出る場合

rootユーザ以外を作成し使用した場合

ユーザに対しての権限を変更する

mysqlにユーザでログイン

```
mysql> show grants for 'root'@'localhost';
+-----------------------------------------+
| Grants for root@localhost                |
+-----------------------------------------+
| GRANT USAGE ON *.* TO 'root'@'localhost' |
+-----------------------------------------+
1 row in set (0.00 sec)
```

USAGE だと権限がない。

すべての権限を与える。
```
mysql>  GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost';

mysql> show grants for 'root'@'localhost';
+--------------------------------------------------+
| Grants for root@localhost                         |
+--------------------------------------------------+
| GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' |
+--------------------------------------------------+
1 row in set (0.00 sec)
```

上記のようになればok

# scaffoldの使用

### 記事編集画面を作成

使用できる型

binary

boolean

date

datetime

decimal

float

integer

primary_key

string

text

time

timestamp

```
$ rails generate scaffold edit user:string title:string date:date category:string text:text url:string
```

### テーブルの作成

```
$ rake db:migrate
```

## localサーバで確認
http://localhost:3000/edits

## Gemfileの編集

```
$ vim Gemfile
gem 'therubyracer', platforms: :ruby	←コメントを外す

追加
gem "twitter"
gem 'oauth'
gem 'json'
gem 'whenever', require: false
```

変更後
```
$ bundle install
```

# twitterのツイートトレンドを取得


## modelの作成
```
$ rails generate model TwitterDatum trend:string tweet:text
```

下記は必要かなわからない
```
#rails db:migrate RAILS_ENV=production
```

### rails generateが動かない場合
```
# spring stop
Spring stopped.

# bin/spring
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

## タスクの作成

```
$ rails generate task twitter
```

下記にタスを書く

```
$ vim lib/tasks/twitter.rake
```

ツイッターからコンシューマキーを取得しておく

```
require 'twitter'

namespace :twitter do
  desc "tweet hello"
  task :tweet => :environment do
    client = get_twitter_client
    # 動作内容書く

      # DBの中身を一度消去
      puts 'データベースの中身を消去' if TwitterDatum.delete_all()
    tweet = "Hello Twitter!"
    #update(client, tweet)
    trend(client)
  end
end

def get_twitter_client
  client = Twitter::REST::Client.new do |config|

config.consumer_key=""
config.consumer_secret=""
config.access_token=""
config.access_token_secret=""
  end
  client
end

def update(client, tweet)
  begin
    tweet = (tweet.length > 140) ? tweet[0..139].to_s : tweet
   # client.update(tweet.chomp)
  rescue => e
    Rails.logger.error "<<twitter.rake::tweet.update ERROR : #{e.message}>>"
  end
end
  def search(client,word, count)
    client.search(word).take(count).each do |tweet|
      tweet = {
      'trend' =>word,
      'tweet' =>tweet.text
      }
      puts 'データベースに保存しました' if TwitterDatum.create(tweet)
    end
  end

  def trend(client)
    client.trends_place(23424856).take(10).each do |trend| # 23424856:日本のtrend

      # trendに関するツイートを表示 引数: 検索ワード,件数
      search(client,trend.name, 10)
  end
  end
```

記述が完了すると下記を実行する

```
$ rails twitter:tweet
```

ここでテーブルの文字コードが「utf8mb4」でない場合エラーがでる。

mysqlにログインする。

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

## コントローラー編集

```
$ vim app/controllers/edits.controller.rb

追加
	def index
	 @articles = TwitterDatum.all
	 #@articles = TwitterDatum.all.order(created_at: 'desc')
	end
end
```
## webページの作成


indexを作成
```
vim app/views/edits/index.html.erb

<h2>tweet </h2>
<ul>
<% str = "a" %>
<% @articles.each do |art|%>
<% if art.trend.to_s.include?(str.to_s)  %>


<% else %>
 <h2><%= art.trend %></h2>
<%  str = art.trend %>
<% end %>
<li><%= art.tweet %></li>
<% end %>
</ul>
```
