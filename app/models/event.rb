class Event < ActiveRecord::Base
  validates :minute, :numericality => {:greater_than => 0, :only_integer => true}
  validates :minute, :presence => true
  validates :player_id, :presence => true
  validates :code, :presence => true

  belongs_to :game
  belongs_to :player
end
