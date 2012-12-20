class Presence < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :player
  belongs_to :practice
end
