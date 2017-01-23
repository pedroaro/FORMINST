json.array!(@estatusadecuacions) do |estatusadecuacion|
  json.extract! estatusadecuacion, :id, :id, :adecuacionId, :fecha, :estatusId, :actual
  json.url estatusadecuacion_url(estatusadecuacion, format: :json)
end
