json.array!(@personas) do |persona|
  json.extract! persona, :id, :id, :usuarioId, :nombres, :apellidos, :fechaNac, :ci, :telefono1, :telefono2, :direccion
  json.url persona_url(persona, format: :json)
end
