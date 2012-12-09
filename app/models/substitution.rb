class Substitution < ActiveRecord::Base
  validates :minute, :numericality => {:greater_than => 0, :only_integer => true}
  validates :minute, :presence => true
  validates :player_in, :presence => true
  validates :player_out, :presence => true

  belongs_to :game
  belongs_to :player_in, :class_name => "Player"
  belongs_to :player_out, :class_name => "Player"
end
