json.array!(@rondas) do |ronda|
  json.extract! ronda, :numero, :inicio_fecha, :inicio_tiempo, :modo_ganar, :torneo_id
  json.url ronda_url(ronda, format: :json)
end
