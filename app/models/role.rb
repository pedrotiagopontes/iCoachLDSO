class Role < ActiveRecord::Base
  acts_as_paranoid
  attr_protected :deleted_at

  belongs_to :user
  belongs_to :club
end
