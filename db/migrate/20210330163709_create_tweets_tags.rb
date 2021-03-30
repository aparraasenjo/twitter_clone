class CreateTweetsTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags_tweets, :id => false do |t|
      t.references :tweet, foreign_key: true
      t.references :tag, foreign_key: true
    end
  end
end
