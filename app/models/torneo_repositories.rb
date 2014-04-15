module TorneoRepository extend Edr::AR::Repository

  set_model_class Torneo

  def self.buscar_torneos_para_portada 
  	print "GG"
    order(:cierre_inscripcion_fecha,:cierre_inscripcion_tiempo).limit(20).where("date(cierre_inscripcion_fecha) > date(:fecha_actual) or ( cierre_inscripcion_tiempo > time :hora_actual and date(cierre_inscripcion_fecha) = date(:fecha_actual) )",{fecha_actual: Time.new.strftime("%F"), hora_actual:Time.new.strftime("%T")})
  end

  def self.buscar_torneos_para_portada 
    #Por Implementar
  end

  def self.buscar_por_id torneo_id
    #Por Implementar
  end
end