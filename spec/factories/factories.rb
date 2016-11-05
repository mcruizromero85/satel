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
    post_detalle_torneo 'https://www.facebook.com/3gpwrLOCOPIEDRA/posts/599468586862802'
    urlstreeming 'http://www.twitch.tv/kripty85'
    vacantes '8'
    estado 'Creado'
    cierre_inscripcion Time.new + (60 * 60 * 24 * 2)
    periodo_confirmacion_en_minutos '20'
    juego
    #association :juego, strategy: :build
  end

  factory :juego do
    id 2
    nombre 'Heroes of The Storm'
    descripcion 'Heroes of The Storm'
    nombre_imagen 'hots.jpg'
    tipo_juego '0'
  end

  factory :gamer do
    nombres 'Matt'
    battletag 'Kripty#1234'    
    apellidos 'Horner'
    correo 'matt@gmail.com'
  end

  factory :inscripcion do
    estado 'No Confirmado'
    association :gamer, strategy: :build
    torneo
  end
end
