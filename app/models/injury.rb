class Injury < ActiveRecord::Base
  acts_as_paranoid

  validates :description, :presence => true
  
  belongs_to :player
end
