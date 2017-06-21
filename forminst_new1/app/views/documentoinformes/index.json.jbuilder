json.array!(@documentoinformes) do |documentoinforme|
  json.extract! documentoinforme, :id, :id, :informeId, :archivo
  json.url documentoinforme_url(documentoinforme, format: :json)
end
