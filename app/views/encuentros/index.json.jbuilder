json.array!(@encuentros) do |encuentro|
  json.extract! encuentro, :gamera_id, :gamerb_id, :posicion_en_ronda, :id_ronda, :flag_ganador, :descripcion, :encuentro_anterior_a_id, :encuentro_anterior_b_id
  json.url encuentro_url(encuentro, format: :json)
end
