# This will guess the User class
FactoryGirl.define do

  factory :ronda do
    numero "1"
    inicio_fecha { |ronda| (Time.new + (60*60*24*(ronda.numero+1))).strftime("%d/%m/%Y") }
    inicio_tiempo "01:38 AM"
    modo_ganar "1"
    torneo
    
  end

  factory :torneo do
    titulo "TORNEO DE CS 1.6 ONLINE - THE LAST CHANCE"
    paginaweb "http://www.bloodzone.net/forums/f25/torneo-de-cs-1-6-online-last-chance-108544/"
    vacantes "8"
    inicio_torneo_fecha { |ronda| (Time.new + (60*60*24*2)).strftime("%d/%m/%Y") }
    inicio_torneo_tiempo "01:38 AM"
    
    factory :torneo_with_rondas do
      after(:build) do |torneo|
        create_list(:ronda, 2, torneo: torneo)
      end
    end  
  end

  def obtener_fecha_ronda_por numero
    "30/06/2014" 
  end

end
