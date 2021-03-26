class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|
      t.text :content
      t.integer :likes
      t.integer :retweets
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
