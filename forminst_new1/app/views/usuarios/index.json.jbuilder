json.array!(@usuarios) do |usuario|
  json.extract! usuario, :id, :id, :user, :ldap, :activo, :password, :email
  json.url usuario_url(usuario, format: :json)
end
