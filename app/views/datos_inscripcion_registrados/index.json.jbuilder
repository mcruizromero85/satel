json.array!(@datos_inscripcion_registrados) do |datos_inscripcion_registrado|
  json.extract! datos_inscripcion_registrado, :datos_inscripcion_id, :valor, :inscripcion_id
  json.url datos_inscripcion_registrado_url(datos_inscripcion_registrado, format: :json)
end
