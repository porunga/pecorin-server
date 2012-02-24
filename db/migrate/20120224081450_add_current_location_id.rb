class AddCurrentLocationId < ActiveRecord::Migration
  def up
    add_column :users, :current_location_id, :text
  end

  def down
    remove_column :users, current_location_id
  end
end
