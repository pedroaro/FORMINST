json.array!(@adecuacions) do |adecuacion|
  json.extract! adecuacion, :id, :id, :PlanFormacionId, :tutorId
  json.url adecuacion_url(adecuacion, format: :json)
end
