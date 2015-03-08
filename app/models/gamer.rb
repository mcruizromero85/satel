class Gamer < ActiveRecord::Base
  has_many :torneos
  has_many :inscripciones
  has_many :authentications, autosave: true

  def etiqueta_para_bracket
  	if self.nick == nil or self.nick == ''
  		return self.nombres
  	else
  		return self.nick
  	end	
  end
end
