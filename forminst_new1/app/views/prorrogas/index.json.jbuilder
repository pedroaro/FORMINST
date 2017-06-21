json.array!(@prorrogas) do |prorroga|
  json.extract! prorroga, :id, :id, :planFormacionId
  json.url prorroga_url(prorroga, format: :json)
end
