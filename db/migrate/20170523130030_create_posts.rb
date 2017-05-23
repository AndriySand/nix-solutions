class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :url
      t.text :body
      t.string :author

      t.timestamps null: false
    end
    add_index :posts, :title, unique: true
  end
end
