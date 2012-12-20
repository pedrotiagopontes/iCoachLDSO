class Player < ActiveRecord::Base
  acts_as_paranoid

  validates :height, :numericality => {:greater_than => 0}
  validates :weight, :numericality => {:greater_than => 0}
  validates :number, :numericality => {:only_integer => true}

#  has_and_belongs_to_many :teams
  has_many :playersteams
  has_many :teams, :through => :playersteams
  has_many :playersgames
  has_many :games, :through => :playersgames
  has_many :presences
  has_many :practices, :through => :presences
  has_many :events
  has_many :injuries
  has_many :convocations
  has_many :games, :through => :convocations
  has_many :substituions

  	#def starter?(game)
		#r = self.playersgames.find_by_game_id(game.id)
	  #  return r.starter
	#end

end
