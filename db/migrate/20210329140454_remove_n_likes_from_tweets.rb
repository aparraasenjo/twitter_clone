class RemoveNLikesFromTweets < ActiveRecord::Migration[5.2]
  def change
    remove_column :tweets, :n_likes, :integer
  end
end
