class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
      t.integer :user_id, :null => false
      t.integer :level
      t.string :level_name
      t.string :image_url
      t.string :badge_type, :null => false
      t.timestamps
    end
  end
end
