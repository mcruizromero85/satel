json.array!(@prueba2s) do |prueba2|
  json.extract! prueba2, :estado
  json.url prueba2_url(prueba2, format: :json)
end
