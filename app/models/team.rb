class Team < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :club
#  has_and_belongs_to_many :players
  has_many :playersteams
  has_many :players, :through => :playersteams
  has_many :games
  has_many :practices
end
