class ChangeColumsOidToPicture < ActiveRecord::Migration[5.1]
  def change
    #change_column :pictures, :image, :oid
    remove_column :pictures, :image
    add_column :pictures, :image, :string, :null => false
    #execute 'ALTER TABLE pictures ALTER COLUMN image TYPE oid USING (image::oid)'
  end
end
