json.array!(@tipoactividads) do |tipoactividad|
  json.extract! tipoactividad, :id, :id, :concepto, :grupoActividadesId, :subGrupoActividadId
  json.url tipoactividad_url(tipoactividad, format: :json)
end
