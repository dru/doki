class CreateReferences < ActiveRecord::Migration
  def self.up
    create_table :references do |t|
      t.integer :parent_id
      t.integer :child_id
      t.string  :reference_card_name
      t.string  :reference_type
    end
  end

  def self.down
    drop_table :references
  end
end