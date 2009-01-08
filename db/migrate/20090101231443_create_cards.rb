class CreateCards < ActiveRecord::Migration
  def self.up
    create_table :cards do |t|
      t.string :name
      t.integer :current_revision_id
      t.string :type
      t.text :body

      t.timestamps
    end
  end

  def self.down
    drop_table :cards
  end
end
