json.array!(@informeactividads) do |informeactividad|
  json.extract! informeactividad, :id, :id, :informeId, :actividadId
  json.url informeactividad_url(informeactividad, format: :json)
end
