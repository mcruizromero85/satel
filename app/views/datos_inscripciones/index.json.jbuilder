json.array!(@datos_inscripciones) do |datos_inscripcion|
  json.extract! datos_inscripcion, :inscripcion_id, :nombre_dato, :valor_dato
  json.url datos_inscripcion_url(datos_inscripcion, format: :json)
end
