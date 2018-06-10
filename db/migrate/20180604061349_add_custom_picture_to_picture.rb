class AddCustomPictureToPicture < ActiveRecord::Migration[5.1]
  def change
    add_column :pictures, :custom_image, :string
  end
end
