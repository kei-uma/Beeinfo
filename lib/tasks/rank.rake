require 'google/apis/analytics_v3'
require 'google/api_client/auth/key_utils'
require 'yaml'

namespace :rank do
  desc "rank"
  task :rank => :environment do

  puts 'データベースの中身を消去' if Ranking.delete_all()
  ## アプリの証明書をファイルから読み込む
  options = YAML.load_file("./config/ga_config.yml")
  email      = options['service_account_email']
  key_file   = Rails.root.join('config','Beeinfo-7be56237e4ff.p12').to_s
  key_secret = options['key_secret']
  view_id = options['view_id']

  ## インスタンスを生成
  service = Google::Apis::AnalyticsV3::AnalyticsService.new
  key = Google::APIClient::KeyUtils.load_from_pkcs12(key_file, key_secret)

  service.authorization = Signet::OAuth2::Client.new(
    :token_credential_uri => 'https://accounts.google.com/o/oauth2/token',
    :audience             => 'https://accounts.google.com/o/oauth2/token',
    :scope                => Google::Apis::AnalyticsV3::AUTH_ANALYTICS_READONLY,
    :issuer               => email,
    :signing_key          => key
  )

  ## トークンをリクエストする
  service.authorization.fetch_access_token!

  ## 取得するデータの期間を指定する
  start_date = (DateTime.now - 20).strftime("%Y-%m-%d")
  end_date   = DateTime.now.strftime("%Y-%m-%d")

  ## URL(pagepath)ごとのページビュー、ユニークページビューを
  ## ユニークページビューの降順で要求する
  dimension = 'ga:pagePath'
  metric    = 'ga:pageviews,ga:uniquePageviews'
  sort      = '-ga:pageviews'
  filters='ga:pagepath=~/edits/[0-9]+$'

  ## gadataには順に'ga:pagePath', 'ga:pageviews', 'ga:uniquePageviews'の値が入る
  gadata = service.get_ga_data(
    "ga:#{view_id}",
    start_date,
    end_date,
    metric,
    dimensions: dimension,
    sort: sort,
    filters: filters
  )

  # 取得結果を表示
  puts gadata.column_headers.collect{|c| c.name}.join("\t")
  count = 0
  gadata.rows.each do |r|
    count += 1
    print count
    puts r.join("\t")
  end

  puts gadata.column_headers.collect{|c| c.name}.join("\t")
  gadata.rows.each do |r|
    tmp = r[0].gsub("edits/","")
    tt = Edit.find_by(id: tmp)

    ranking = {
      'edit_id' => tt.id,
      'category_id' => tt.category_id
    }

    if Ranking.create(ranking)
    end

    end

  end

end
