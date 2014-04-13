 class TorneoData < ActiveRecord::Base
 	self.table_name = "torneos"
	validates_presence_of :titulo, :message => "El título es un dato obligatorio" 
	validates_length_of :titulo, :within => 30..100, :message => "El torneo debe tener como mínimo 30 caracteres y como máximo 100"
	validates_format_of(:paginaweb, :with => URI.regexp(['http']), :on => :create, :message=>"Debe tener el formato de una url")

	belongs_to :juego , autosave: false
	has_many :rondas , autosave: true
	has_many :inscripcions, autosave: true
end
