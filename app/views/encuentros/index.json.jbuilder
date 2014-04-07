json.array!(@encuentros) do |encuentro|
  json.extract! encuentro, :estado, :posicion_en_ronda, :id_inscripcion_gamer_a, :id_inscripcion_gamer_b, :id_inscripcion_gamer_ganador
  json.url encuentro_url(encuentro, format: :json)
end
