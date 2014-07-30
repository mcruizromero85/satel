# This will guess the User class
FactoryGirl.define do

  factory :orden do
    dni "33333333"
    password "a123456"    
    sku "2004156629137"
    medio_de_pago "Tarjeta Ripley"
    
  end

  factory :ronda do
    numero "1"
    inicio_fecha { |ronda| (Time.new + (60*60*24*(ronda.numero+1))).strftime("%d/%m/%Y") }
    inicio_tiempo "01:40 AM"
    modo_ganar "1"
    
  end

  factory :torneo do
    titulo "TORNEO DE CS 1.6 ONLINE - THE LAST CHANCE"
    paginaweb "http://www.bloodzone.net/forums/f25/torneo-de-cs-1-6-online-last-chance-108544/"
    vacantes "8"
    cierre_inscripcion_fecha { |cierre_inscripcion_fecha| (Time.new + (60*60*24*2)).strftime("%d/%m/%Y") }
    cierre_inscripcion_tiempo "01:40 AM"
    
  end  
end
