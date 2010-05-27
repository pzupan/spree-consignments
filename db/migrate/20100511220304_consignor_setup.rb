class ConsignorSetup < ActiveRecord::Migration
  def self.up
    create_table :consignors do |t|
	    t.integer :user_id
      t.string :first_name
      t.string :last_name
      t.string :address1
      t.string :address2
      t.string :city
      t.integer :state_id
      t.string :zip_code
      t.string :phone
      t.string :fax
      t.string :email
      t.text :notes
      t.timestamps
    end

    add_index(:consignors, :id)
    add_index(:consignors, :user_id)
    add_index(:consignors, :last_name)
    add_index(:consignors, :email)
    add_index(:consignors, :state_id)
  end

  def self.down
    drop_table :consignors
  end
end