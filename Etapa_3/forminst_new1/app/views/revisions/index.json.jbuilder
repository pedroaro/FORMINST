json.array!(@revisions) do |revision|
  json.extract! revision, :id, :id, :informeId, :fecha, :usuarioId, :adecuacionId, :estatusId
  json.url revision_url(revision, format: :json)
end
