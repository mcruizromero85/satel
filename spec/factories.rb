# This will guess the User class
FactoryGirl.define do

  factory :ronda do
    numero '1'
    inicio_fecha { Time.new + (60 * 60 * 24 * 2) + numero }
    inicio_tiempo '01:40 AM'
    modo_ganar '1'
  end

  factory :torneo do
    titulo 'TORNEO DE CS 1.6 ONLINE - THE LAST CHANCE'
    paginaweb 'http://www.bloodzone.net/forums/f25/torneo-de-cs-1-6-online-last-chance-108544/'
    vacantes '8'
    estado 'Creado'
    cierre_inscripcion Time.new + (60 * 60 * 24 * 2)
    periodo_confirmacion_en_minutos '20'
  end

  factory :gamer do
    nombres 'Matt'
    apellidos 'Horner'
    correo 'matt@gmail.com'
  end

  factory :inscripcion do
    estado 'No Confirmado'
    association :gamer, strategy: :build
    torneo
  end
end
