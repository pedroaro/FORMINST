json.array!(@usuarioentidads) do |usuarioentidad|
  json.extract! usuarioentidad, :id, :id, :usuarioId, :entidadesId
  json.url usuarioentidad_url(usuarioentidad, format: :json)
end
