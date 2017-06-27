json.array!(@observacionactividadinformes) do |observacionactividadinforme|
  json.extract! observacionactividadinforme, :id, :id, :informeActividadId, :revisionId, :observacion
  json.url observacionactividadinforme_url(observacionactividadinforme, format: :json)
end
