class CreateComments < ActiveRecord::Migration[8.1]
  def change
    create_table :comments do |t|
      t.references :article, null: false, foreign_key: true
      t.string :name
      t.string :email
      t.text :content
      t.string :status

      t.timestamps
    end
  end
end
