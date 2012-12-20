class Game < ActiveRecord::Base
  acts_as_paranoid
  attr_protected :deleted_at

  belongs_to :team
  has_many :events
  has_many :convocations
  has_many :players, :through => :convocations
  has_many :substitutions
end
