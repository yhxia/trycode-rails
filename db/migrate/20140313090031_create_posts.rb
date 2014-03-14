class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.datetime :time
      t.string :site
      t.string :author
      t.string :content
      t.string :author_url
      t.string :post_url
      t.integer :uv_attitude
      t.integer :uv_comment
      t.string :uv_radar

      t.timestamps
    end
  end
end
