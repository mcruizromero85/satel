module RondasHelper	
  def self.win_format_final(torneo)
  	if torneo.vacantes == 16 
  	  "BO" + torneo.rondas.where(numero: 4).first.modo_ganar.to_s 
  	else
  	  "BO" + torneo.rondas.where(numero: 3).first.modo_ganar.to_s 
  	end
  end

  def self.win_format_semifinal(torneo)
  	if torneo.vacantes == 16
  	  "BO" + torneo.rondas.where(numero: 3).first.modo_ganar.to_s 
  	else
  	  "BO" + torneo.rondas.where(numero: 2).first.modo_ganar.to_s 
  	end
  end

  def self.win_format_others_rounds(torneo)
  	if torneo.vacantes == 16
  	  "BO" + torneo.rondas.where(numero: 2).first.modo_ganar.to_s 
  	else
  	  "BO" + torneo.rondas.where(numero: 1).first.modo_ganar.to_s 
  	end
  end
end
