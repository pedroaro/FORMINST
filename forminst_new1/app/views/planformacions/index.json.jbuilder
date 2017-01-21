json.array!(@planformacions) do |planformacion|
  json.extract! planformacion, :id, :id, :fechaInicio, :fechaFin, :activo, :instructorId, :tutorId
  json.url planformacion_url(planformacion, format: :json)
end
