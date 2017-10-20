class AddColumnToTwitterData < ActiveRecord::Migration[5.0]
  def change
    add_column :twitter_data, :tweet_id, :string

    add_column :twitter_data, :image_url, :text

    add_column :twitter_data, :user, :string

    add_column :twitter_data, :user_id, :string

    add_column :twitter_data, :user_icon_url, :text

    add_column :twitter_data, :tweet_time, :datetime

    add_column :twitter_data, :tweet_url, :text
  end
end
