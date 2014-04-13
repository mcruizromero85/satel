class Juego < ActiveRecord::Base
	has_many :torneos
	belongs_to :asociado
end
