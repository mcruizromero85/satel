json.array!(@torneos) do |torneo|
  json.extract! torneo, :nombre, :juego, :vacantes, :cierre_inscripcion
  json.url torneo_url(torneo, format: :json)
end
