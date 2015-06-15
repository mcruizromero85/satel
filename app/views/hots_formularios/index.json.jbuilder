json.array!(@hots_formularios) do |hots_formulario|
  json.extract! hots_formulario, :inscripcion_id, :nombre_equipo
  json.url hots_formulario_url(hots_formulario, format: :json)
end
