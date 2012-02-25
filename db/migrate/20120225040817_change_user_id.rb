class ChangeUserId < ActiveRecord::Migration
  def up
    remove_column :levels, :user_id
    add_column :levels, :facebook_id, :string, :null => false
  end

  def down
    add_column :levels, :user_id, :string, :null => false
    remove_column :levels, :facebook_id
  end
end
