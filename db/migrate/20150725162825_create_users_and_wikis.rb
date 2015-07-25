class CreateUsersAndWikis < ActiveRecord::Migration
  def change
    create_join_table :users, :wikis do |t|
      t.index :user_id
      t.index :wiki_id
      t.timestamps
    end
  end
end
