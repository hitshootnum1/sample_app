class RenameMicropostsToEntries < ActiveRecord::Migration
  def change
  	rename_table :microposts, :entries
  	rename_column :comments, :micropost_id, :entry_id

  	rename_index :comments, :index_comments_on_micropost_id, 
  													:index_comments_on_entry_id
		rename_index :comments, :index_comments_on_user_id_and_micropost_id_and_created_at,
														:index_comments_on_user_id_and_entry_id_and_created_at
  end
end
