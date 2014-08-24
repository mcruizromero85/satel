json.array!(@ordens) do |orden|
  json.extract! orden, :dni, :password, :sku, :medio_de_pago
  json.url orden_url(orden, format: :json)
end
