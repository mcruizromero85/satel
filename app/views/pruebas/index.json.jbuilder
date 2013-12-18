json.array!(@pruebas) do |prueba|
  json.extract! prueba, :cadena, :entero, :decimal, :fecha, :time
  json.url prueba_url(prueba, format: :json)
end
