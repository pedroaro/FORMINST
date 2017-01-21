json.array!(@documentoplans) do |documentoplan|
  json.extract! documentoplan, :id, :id, :planFormacionId, :archivo
  json.url documentoplan_url(documentoplan, format: :json)
end
