json.array!(@permisos) do |permiso|
  json.extract! permiso, :id, :id, :concepto
  json.url permiso_url(permiso, format: :json)
end
