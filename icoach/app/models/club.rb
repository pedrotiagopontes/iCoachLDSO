class Club < ActiveRecord::Base
	has_many :roles, :dependent => :destroy
	has_many :users, :through => :roles
	accepts_nested_attributes_for :roles, :allow_destroy => true
	#accepts_nested_attributes_for :users, :reject_if => :all_blank, :allow_destroy => true
	
	has_many :teams
end
