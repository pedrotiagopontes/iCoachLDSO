class Playersteam < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :player
  belongs_to :team
end
