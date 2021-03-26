class FixLike < ActiveRecord::Migration[5.2]
  def change
    rename_column :tweets, :likes, :n_likes
  end
end
