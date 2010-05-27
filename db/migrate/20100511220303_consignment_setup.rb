class ConsignmentSetup < ActiveRecord::Migration
  def self.up
    create_table :consignments do |t|
	    t.integer :consignor_id
	    t.integer :commission, :default => 0, :null => false
      t.boolean :paid, :default => 0
      t.text :notes
      t.timestamps
    end
    add_column :products, :consignment_id, :integer

    add_index(:consignments, :id)
    add_index(:consignments, :consignor_id)
    add_index(:products, :consignment_id)
  end

  def self.down
    drop_table :consignments
    drop_index(:products, :consignment_id)
    remove_column :products, :consignment_id
  end
end