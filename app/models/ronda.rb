class Ronda < ActiveRecord::Base
	belongs_to :torneo
	has_many :encuentros
end
