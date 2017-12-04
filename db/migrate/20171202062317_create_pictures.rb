class CreatePictures < ActiveRecord::Migration[5.1]
  def change
    create_table :pictures do |t|
      t.text :content
      t.integer :user_id
      t.string :title
      t.string :image

      t.timestamps
    end
  end
end
