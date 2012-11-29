class Injury < ActiveRecord::Base
  validates :description, :presence => true
  
  belongs_to :player
end
