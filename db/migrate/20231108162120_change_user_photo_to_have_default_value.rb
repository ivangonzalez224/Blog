class ChangeUserPhotoToHaveDefaultValue < ActiveRecord::Migration[7.1]
  def change
    change_column :users, :photo, :string, default: 'https://i.pinimg.com/474x/ec/e2/b0/ece2b0f541d47e4078aef33ffd22777e.jpg'
  end
end
