# 使用環境
ruby : 2.4.1

rails : 5.0.2

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
 $ create user 'kei'@localhost identified by 'root';
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
 ``` Gemfile
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

 ```
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
mysql> show grants for 'kei'@'localhost';
+-----------------------------------------+
| Grants for kei@localhost                |
+-----------------------------------------+
| GRANT USAGE ON *.* TO 'kei'@'localhost' |
+-----------------------------------------+
1 row in set (0.00 sec)
```

USAGE だと権限がない。

すべての権限を与える。
```
mysql>  GRANT ALL PRIVILEGES ON *.* TO 'kei'@'localhost';

mysql> show grants for 'kei'@'localhost';
+--------------------------------------------------+
| Grants for kei@localhost                         |
+--------------------------------------------------+
| GRANT ALL PRIVILEGES ON *.* TO 'kei'@'localhost' |
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

'''
vim Gemfile
gem 'therubyracer', platforms: :ruby	←コメントを外す

追加
gem "twitter"
gem 'oauth'
gem 'json'
gem 'whenever', require: false
'''
## タスクの作成
