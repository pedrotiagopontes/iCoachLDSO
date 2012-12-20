class Practice < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :team
  has_many :presences
  has_many :players, :through => :presences
end
