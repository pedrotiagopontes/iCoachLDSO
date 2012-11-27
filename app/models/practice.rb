class Practice < ActiveRecord::Base
  belongs_to :team
  has_many :presences
  has_many :players, :through => :presences
end
