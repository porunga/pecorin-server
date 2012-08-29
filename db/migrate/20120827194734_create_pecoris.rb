class CreatePecoris < ActiveRecord::Migration
  def change
    create_table :pecoris do |t|
      t.integer :pecorer_id
      t.integer :pecoree_id
      t.string :pecori_type
      t.timestamps
    end
  end
end
