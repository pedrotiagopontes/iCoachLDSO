class Injury < ActiveRecord::Base
  acts_as_paranoid
  attr_protected :deleted_at

  validates :description, :presence => true
  
  belongs_to :player
end
