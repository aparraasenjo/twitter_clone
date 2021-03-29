class AddRepostToTweet < ActiveRecord::Migration[5.2]
  def change
    add_column :tweets, :repost_id, :integer
  end
end
