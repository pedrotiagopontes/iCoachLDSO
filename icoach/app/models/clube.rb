class Clube < ActiveRecord::Base
	validates :nome,  :presence => true
	validates :sigla,  :presence => true

	has_many :equipas
end
