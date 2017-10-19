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
  s = []
  File.foreach("twitterOauth.txt") { |line|
    s << line.chomp
  }
  client = Twitter::REST::Client.new do |config|
    config.consumer_key = s[0]
    config.consumer_secret = s[1]
    config.access_token = s[2]
    config.access_token_secret = s[3]
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
