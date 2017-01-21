json.array!(@actividadejecutadas) do |actividadejecutada|
  json.extract! actividadejecutada, :id, :id, :descripcion, :fecha, :actual, :informeActividadId
  json.url actividadejecutada_url(actividadejecutada, format: :json)
end
