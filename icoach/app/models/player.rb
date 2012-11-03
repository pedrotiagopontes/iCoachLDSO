class Player < ActiveRecord::Base
  validates :height, :numericality => {:greater_than => 0}
  validates :weight, :numericality => {:greater_than => 0}
  validates :number, :numericality => {:only_integer => true}

  has_and_belongs_to_many :teams
end
