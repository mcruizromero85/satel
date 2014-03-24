json.array!(@inscripcions) do |inscripcion|
  json.extract! inscripcion, :fecha_inscripcion, :hora_inscripcion, :estado_confirmacion, :peso_participacion, :gamer_id, :torneo_id
  json.url inscripcion_url(inscripcion, format: :json)
end
