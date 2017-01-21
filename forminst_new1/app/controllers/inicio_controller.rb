class InicioController < ApplicationController
	layout 'inicio'

	def index
		puts "estoy entrando al index"
	end

	def autenticar
		ldap= Net::LDAP.new(:host=>"strix.ciens.ucv.ve",:port=>389, :auth=>{:method=> :simple, :username=>"cn=zaira, dc=ciens, dc=ucv, dc=ve", :password => "1z0cpal"})
		correo= params[:correo]
		clave= paramas[:clave]
		result = ldap.bind_as(:base => "dc=ciens, dc=ucv, dc=ve", :filter => "(uid=#{correo})", :password => clave)
		if result
			@usuario = Usuario.where(user: correo)
			if @usuario.activo == 1
				if @usuario.ldap == 1

				else
					flash[:mensaje]= "El usuario no debe autenticarse por ldap"
				end
			else
				flash[:mensaje]= "El usuario no está activo"
			end
		else
		end
	end

end
