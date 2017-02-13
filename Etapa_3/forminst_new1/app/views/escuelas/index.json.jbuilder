json.array!(@escuelas) do |escuela|
  json.extract! escuela, :id, :id, :nombre
  json.url escuela_url(escuela, format: :json)
end
