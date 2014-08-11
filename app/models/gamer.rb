class Gamer < ActiveRecord::Base
	has_many :torneos
	has_many :inscripcions
	has_many :authentications, autosave: true

end
