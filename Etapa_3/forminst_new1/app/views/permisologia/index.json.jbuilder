json.array!(@permisologia) do |permisologium|
  json.extract! permisologium, :id, :id, :permisosId, :usuarioId, :attribute, :read, :write
  json.url permisologium_url(permisologium, format: :json)
end
