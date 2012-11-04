class Event < ActiveRecord::Base
  validates :minute, :numericality => {:greater_than => 0, :only_integer => true}

  belongs_to :game
  belongs_to :player
end
