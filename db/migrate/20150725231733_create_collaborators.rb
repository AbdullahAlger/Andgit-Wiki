class CreateCollaborators < ActiveRecord::Migration
  def change
    create_table :collaborators do |t|
      t.integer :user_id, null: false
      t.integer :wiki_id, null: false
      t.timestamps
    end
    add_index :collaborators, :user_id
    add_index :collaborators, :wiki_id
  end
end