json.array!(@documentos) do |documento|
  json.extract! documento, :id, :id, :informeActividadId, :archivo
  json.url documento_url(documento, format: :json)
end
