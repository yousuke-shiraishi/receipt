class RenameBlogIdColumnFavorites < ActiveRecord::Migration[5.1]
  def change
    rename_column :favorites, :blog_id, :user_id
  end
end
