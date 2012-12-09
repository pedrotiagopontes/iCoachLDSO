class Game < ActiveRecord::Base
  belongs_to :team
  has_many :events
  has_many :convocations
  has_many :players, :through => :convocations
  has_many :substitutions
end
