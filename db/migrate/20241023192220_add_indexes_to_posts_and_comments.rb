class AddIndexesToPostsAndComments < ActiveRecord::Migration[7.2]
  def change
    unless index_exists?(:posts, :user_id)
      add_index :posts, :user_id
    end
  end
end
