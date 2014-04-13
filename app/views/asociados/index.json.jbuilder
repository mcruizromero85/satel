json.array!(@asociados) do |asociado|
  json.extract! asociado, :nombre, :descripcion, :juego_id
  json.url asociado_url(asociado, format: :json)
end
