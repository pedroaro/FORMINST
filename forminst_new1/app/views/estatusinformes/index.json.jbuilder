json.array!(@estatusinformes) do |estatusinforme|
  json.extract! estatusinforme, :id, :id, :informeId, :fecha, :estatusId, :actual
  json.url estatusinforme_url(estatusinforme, format: :json)
end
