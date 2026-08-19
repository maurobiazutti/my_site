class RemoveContentFromArticles < ActiveRecord::Migration[8.1]
  def change
    remove_column :articles, :content, :text
  end
end
