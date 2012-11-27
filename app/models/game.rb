class Game < ActiveRecord::Base
  belongs_to :team
  has_many :playersgames
  has_many :players, :through => :playersgames
  has_many :events
end
