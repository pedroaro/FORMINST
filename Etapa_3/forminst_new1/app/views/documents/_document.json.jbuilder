json.extract! document, :id, :filename, :content_type, :file_contents, :created_at, :updated_at, :instructor_id, :tutor_id, :adecuacion_id, :informe_id
json.url document_url(document, format: :json)
