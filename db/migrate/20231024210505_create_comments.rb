class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.text :text
      t.references :post, foreign_key: { to_table: :posts }
      t.references :user, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
