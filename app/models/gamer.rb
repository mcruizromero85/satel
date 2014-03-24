class Gamer < ActiveRecord::Base
	has_many :torneos
	has_many :inscripcions
end
