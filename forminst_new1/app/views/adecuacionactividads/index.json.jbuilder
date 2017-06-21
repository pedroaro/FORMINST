json.array!(@adecuacionactividads) do |adecuacionactividad|
  json.extract! adecuacionactividad, :id, :id, :adecuacionId, :actividadId, :anulada, :semestre
  json.url adecuacionactividad_url(adecuacionactividad, format: :json)
end
