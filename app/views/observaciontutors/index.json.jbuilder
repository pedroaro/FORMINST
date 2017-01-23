json.array!(@observaciontutors) do |observaciontutor|
  json.extract! observaciontutor, :id, :id, :informeActividadId, :observacion, :fecha, :actual
  json.url observaciontutor_url(observaciontutor, format: :json)
end
