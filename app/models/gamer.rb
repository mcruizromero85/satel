class Gamer < ActiveRecord::Base
  has_many :torneos
  has_many :inscripciones
  has_many :authentications, autosave: true


end
