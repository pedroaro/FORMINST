json.array!(@observacionactividadadecuacions) do |observacionactividadadecuacion|
  json.extract! observacionactividadadecuacion, :id, :id, :revisionId, :adecuacionActividadId, :observacion, :fecha
  json.url observacionactividadadecuacion_url(observacionactividadadecuacion, format: :json)
end
