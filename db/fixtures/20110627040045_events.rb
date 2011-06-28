class Events < ActiveRecord::Migration
  def self.up
    add_index :events, :venue
  end

  def self.down
    remove_index :events, :venue
  end
end
