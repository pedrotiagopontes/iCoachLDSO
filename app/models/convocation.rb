class Convocation < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :player
  belongs_to :game
end
