class RenameColumnPictureSerachWord < ActiveRecord::Migration[5.1]
  def change
    rename_column :pictures, :serch_word, :search_word
  end
end
