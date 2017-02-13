json.array!(@resultados) do |resultado|
  json.extract! resultado, :id, :id, :actividadId, :tipoResultadoId, :concepto
  json.url resultado_url(resultado, format: :json)
end
