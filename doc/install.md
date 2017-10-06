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
  username: 追加
  password: 追加
  host: localhost

  ## データベースの作成
  ```
  $ rake db:create
  ```

```

## modelの設定
```
$ rails generate model TwitterDatum trend:string tweet:text
$ rake db;migrate
```

下記を実行すると上書きされるか聞かれるのでnoを入力

```
$ rails generate scaffold edit user:string title:string date:date category:string text:text url:string
$ rake db;migrate
```

## taskの作成
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

    config.consumer_key="追加"
    config.consumer_secret="追加"
    config.access_token="追加"
    config.access_token_secret="追加"
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

## taskの実行
```
$ rails twitter:tweet
```

## サーバの起動
```
rails s
```

とりあえず、動くはず？
