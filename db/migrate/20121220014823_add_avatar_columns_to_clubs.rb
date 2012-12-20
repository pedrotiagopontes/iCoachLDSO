class AddAvatarColumnsToClubs < ActiveRecord::Migration
  def self.up
    add_attachment :clubs, :avatar
  end

  def self.down
    remove_attachment :clubs, :avatar
  end
end
