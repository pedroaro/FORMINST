json.array!(@tipoestatuses) do |tipoestatus|
  json.extract! tipoestatus, :id, :id, :informeId
  json.url tipoestatus_url(tipoestatus, format: :json)
end
