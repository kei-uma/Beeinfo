json.extract! twitter_datum, :id, :created_at, :updated_at
json.url twitter_datum_url(twitter_datum, format: :json)
