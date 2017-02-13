json.array!(@entidads) do |entidad|
  json.extract! entidad, :id, :id, :nombre, :escuelaId
  json.url entidad_url(entidad, format: :json)
end
