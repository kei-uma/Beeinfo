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

config.consumer_key="AIlKbEH3GvK3HxbPoN7gfm9Ku"
config.consumer_secret="ua58S6nFNPReeCKJCuZh9xCbVDwaRWsF77xXPepOyONzTlI2kb"
config.access_token="3004005439-UfmYvvhWYCsdXlhKOa778QPSWu5lFlx3TL05sVW"
config.access_token_secret="Sr21T3IxJ4BLs9gDwAJvfuxbNCOHWdnF8UAB0ar5b6vqI"
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
