class Note < ActiveRecord::Base
  acts_as_paranoid
  attr_accessible :deleted_at

  belongs_to :user
end
