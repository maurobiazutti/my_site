class DropComments < ActiveRecord::Migration[8.1]
  def change
    drop_table :comments
  end
end
