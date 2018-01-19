class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :content
      t.boolean :published, default: false
      t.datetime :published_at, required: false
      t.integer :likes, default: 0
      t.timestamps
    end
  end
end
