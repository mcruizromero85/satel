json.array!(@pruebas) do |prueba|
  json.extract! prueba, :titulo, :descripcion, :formato, :modalidad, :juego_id, :modalidad_reporte_victoria, :vacantes, :cierre_inscripcion_fecha, :cierre_inscripcion_tiempo, :cierre_check_in_fecha, :cierre_check_in_tiempo, :inicio_torneo_fecha, :inicio_torneo_tiempo
  json.url prueba_url(prueba, format: :json)
end
