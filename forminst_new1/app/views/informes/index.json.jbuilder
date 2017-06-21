json.array!(@informes) do |informe|
  json.extract! informe, :id, :id, :PlanFormacionId, :tutorId, :opinionTutor, :conclusiones
  json.url informe_url(informe, format: :json)
end
