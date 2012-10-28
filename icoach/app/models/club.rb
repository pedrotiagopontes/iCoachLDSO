class Club < ActiveRecord::Base
	has_many :roles
	has_many :users, :through => :roles
	accepts_nested_attributes_for :roles
	
	has_many :teams
end
