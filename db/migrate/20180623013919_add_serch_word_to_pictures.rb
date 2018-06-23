class AddSerchWordToPictures < ActiveRecord::Migration[5.1]
  def change
    add_column :pictures, :serch_word, :string
  end
end
