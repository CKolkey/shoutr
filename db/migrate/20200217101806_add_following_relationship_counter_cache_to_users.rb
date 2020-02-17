class AddFollowingRelationshipCounterCacheToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :followed_users_count, :integer, null: false, default: 0
    add_column :users, :followers_count, :integer, default: 0, null: false
  end
end
