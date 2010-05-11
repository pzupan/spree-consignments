class ConsignmentSetup < ActiveRecord::Migration
  def self.up
    create_table :consignments do |t|
	t.integer :user_id
      t.string :name
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state_id
      t.string :zip_code
      t.string :phone
      t.string :fax
      t.string :email
	t.integer :commission, :default => 0, :null => false
      t.text :notes
  
      t.timestamps
    end
    add_column :products, :consignment_id, :integer

    add_index(:consignments, :id)
    add_index(:consignments, :user_id)
    add_index(:consignments, :name)
    add_index(:consignments, :email)
    add_index(:products, :consignment_id)
  end

  def self.down
    drop_table :consignments
    drop_index(:products, :consignment_id)
    remove_column :products, :consignment_id
  end
end