class Substitution < ActiveRecord::Base
  belongs_to :game
  belongs_to :player_in, :class_name => "Player"
  belongs_to :player_out, :class_name => "Player"
end
