json.array!(@actividads) do |actividad|
  json.extract! actividad, :id, :id, :tipoActividadId, :actividad, :anulada
  json.url actividad_url(actividad, format: :json)
end
