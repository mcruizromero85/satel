json.array!(@inscripciones) do |inscripcion|
  json.extract! inscripcion, :torneo_id, :gamer_id, :fecha, :hora
  json.url inscripcion_url(inscripcion, format: :json)
end
