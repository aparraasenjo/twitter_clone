class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.belongs_to :tweet, foreign_key: true

      t.timestamps
    end
  end
end
