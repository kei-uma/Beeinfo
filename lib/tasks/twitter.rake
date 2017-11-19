require 'twitter'
require 'oauth'
require 'time'
require 'json'

namespace :twitter do
  desc "tweet hello"
  task :tweet => :environment do
    p Time.new
    client = get_twitter_client
    # 動作内容書く

    # DBの中身を一度消去
    #puts 'データベースの中身を消去' if TwitterDatum.delete_all()
    tweet = "Hello Twitter!"
    #update(client, tweet)
    trend(client)
    apiLimit
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

def search(client, word, count, trend_id)
  i = 0
  l = 0
  client.search(word, exclude: "retweets").take(count).each do |tweet|
    t = TwitterDatum.find_by(tweet_id: tweet.id.to_s)
    if t == nil
      # ツイートにurlが含まれるか確認
      if !tweet.media.empty? then
          # urlがある場合現状ではdbがハッシュではないのurlをひとつだけ取得
          tweet.media.take(1).each do |media|
            #ツイートに画像が含まれる場合
            tweet = {
              'trend' =>word,
              'tweet' =>tweet.text,
              'tweet_id' =>tweet.id.to_s,
              #画像をnilとして保存
              'image_url' =>media.media_url.to_s, #とりあえずひとつだけ
              'user' =>tweet.user.name,
              'user_id' =>tweet.user.screen_name, #userの@以下
              'user_icon_url' =>tweet.user.profile_image_url,
              'tweet_time' =>tweet.created_at,
              'tweet_url' =>tweet.url
            }
          end
      else	#ツイートに画像が含まれない場合
        tweet = {
          'trend' =>word,
          'tweet' =>tweet.text,
          'tweet_id' =>tweet.id.to_s,
          #画像をnilとして保存
          'image_url' =>nil,
          'user' =>tweet.user.name,
          'user_id' =>tweet.user.screen_name, #userの@以下
          'user_icon_url' =>tweet.user.profile_image_url,
          'tweet_time' =>tweet.created_at,
          'tweet_url' =>tweet.url
        }
      end
      if TwitterDatum.create(tweet)
        l += 1
        trend_twitter = {
          'twitter_datum_id' => TwitterDatum.last.id,
          'trend_id' => trend_id
        }
      end
    else	#tweetがすでに存在した場合
      tt = TrendTwitter.find_by(twitter_datum_id: t.id, trend_id: trend_id)
      if tt == nil
        trend_twitter = {
          'twitter_datum_id' => t.id,
          'trend_id' => trend_id
        }
      else	#すでに中間テーブルも存在する場合
        next	#次の繰り返しへ
      end
    end
    if TrendTwitter.create(trend_twitter)
      i += 1
    end
  end
  print("trend: #{word}, tweet: #{l}, intermidiate: #{i} saved\n")
end

def trend(client)
  client.trends_place(23424856).take(5).each do |trend| # 23424856:日本のtrend
    t = Trend.find_by(name: trend.name)
    if t == nil
      trend_new = {
        'name' => trend.name
      }
      if Trend.create(trend_new)
        t_id = Trend.last.id
      else
        puts("トレンドの取得に失敗")
        return
      end
    else
      t_id = t.id
    end
    # trendに関するツイートを表示 引数: 検索ワード,件数
    search(client,trend.name, 3, t_id)
  end
end

def apiLimit
  s = []
  File.foreach("twitterOauth.txt") { |line|
    s << line.chomp
  }
  client = OAuth::Consumer.new( #limitはTwitterGemでは提供されないので直接取得
    s[0],
    s[1],
    site:'https://api.twitter.com/'
  )
  endpoint = OAuth::AccessToken.new(client, s[2], s[3])
  response = endpoint.get('https://api.twitter.com/1.1/application/rate_limit_status.json')

  puts 'rest API'
  #response.header.each do |head|
  #  print head + ':'
  #  puts response.header[head]
  #end
  restAPI = JSON.parse(response.body)
  
  print 'trends/place: '
  puts restAPI["resources"]["trends"]["/trends/place"]
  print 'search/tweets: '
  puts restAPI["resources"]["search"]["/search/tweets"] 
end
