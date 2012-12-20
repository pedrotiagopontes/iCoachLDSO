class Presence < ActiveRecord::Base
  acts_as_paranoid
  attr_protected :deleted_at

  belongs_to :player
  belongs_to :practice
end
