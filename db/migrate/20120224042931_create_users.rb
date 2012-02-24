class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :facebook_id, :null => false
      t.string :pecorin_token
      t.string :access_token
      t.string :name
      t.string :image_url
      t.string :registration_id
      t.timestamps
    end
  end
end
