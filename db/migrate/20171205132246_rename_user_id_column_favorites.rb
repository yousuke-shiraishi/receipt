class RenameUserIdColumnFavorites < ActiveRecord::Migration[5.1]
  def change
   rename_column :favorites, :user_id, :picture_id 
  end
end
