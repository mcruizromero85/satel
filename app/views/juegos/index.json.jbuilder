json.array!(@juegos) do |juego|
  json.extract! juego, :nombre, :descripcion, :asociado_id
  json.url juego_url(juego, format: :json)
end
