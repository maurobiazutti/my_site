class CreateArticles < ActiveRecord::Migration[8.1]
  def change
    create_table :articles do |t|
      t.references :category, null: false, foreign_key: true
      t.string :title
      t.text :content
      t.string :status
      t.datetime :published_at
      t.text :excerpt

      t.timestamps
    end
  end
end
