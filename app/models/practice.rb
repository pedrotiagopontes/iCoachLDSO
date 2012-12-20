class Practice < ActiveRecord::Base
  acts_as_paranoid
  attr_protected :deleted_at

  belongs_to :team
  has_many :presences
  has_many :players, :through => :presences
end
