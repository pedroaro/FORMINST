json.array!(@tiporesultados) do |tiporesultado|
  json.extract! tiporesultado, :id, :id, :tipoActividadId, :idPadre, :concepto
  json.url tiporesultado_url(tiporesultado, format: :json)
end
