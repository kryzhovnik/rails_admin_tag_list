class CreatePlayersMigration < ActiveRecord::Migration
  def self.up
    create_table :players do |t|
      t.timestamps
      t.string :name
    end
  end

  def self.down
    drop_table :players
  end
end
