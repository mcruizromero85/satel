json.array!(@gamers) do |gamer|
  json.extract! gamer, :nick, :correo, :nombres, :apellidos, :fecha_ultimo_login
  json.url gamer_url(gamer, format: :json)
end
