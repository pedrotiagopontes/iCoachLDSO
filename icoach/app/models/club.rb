class Club < ActiveRecord::Base
	has_many :roles
	has_many :users, :through => :roles
	accepts_nested_attributes_for :roles
	#accepts_nested_attributes_for :users, :reject_if => :all_blank, :allow_destroy => true
	
	has_many :teams
end
