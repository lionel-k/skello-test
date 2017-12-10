class CreatePostsComments < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string      :title
      t.string      :content
      t.string      :photo
      t.integer     :rating, default: 0

      t.timestamps null: false
    end

    create_table :comments do |t|
      t.string      :body

      t.references  :post, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
