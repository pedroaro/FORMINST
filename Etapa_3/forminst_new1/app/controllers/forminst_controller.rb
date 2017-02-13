class ForminstController < ApplicationController
	require 'net-ldap'
	require 'pry'

	layout 'ec_aplanes'

	def index
		reset_session
	end

	def autenticar

		#ldap= Net::LDAP.new(:host=>"strix.ciens.ucv.ve",:port=>389, :auth=>{:method=> :simple, :username=>"cn=zaira, dc=ciens, dc=ucv, dc=ve", :password => "1z0cpal"})
		correo= params[:correo] # se toma el valor correo del ususario
		clave= params[:password] # se toma el valor password del usuario
		# se realiza la busqueda del correo y la clave ingresada en la interfaz
		puts "SOOOOOOY el correo"
		puts correo
		puts "SOOOOY LA CLAVE"
		puts clave
		if correo!=nil && correo!="" && clave!=nil && clave!=""
		#	result = ldap.bind_as(:base => "dc=ciens, dc=ucv, dc=ve", :filter => "(uid=#{correo})", :password => clave)
	# cambiado para desactivar LDAP		if result
      		if true
	#			tipo= result.first.tipo[0] #se toma el tipo de ususario que es, si es Docente o Institucional
	#			uid= result.first.uid[0] # se toma su identificador en el sistema de LDAP.
				@usuario= Usuario.where(user: correo).take
   #     @usuario= Usuario.where(user: correo).take

				puts "****************+SOOOY EL USUARIO activooo"
				if @usuario
          		tipo=@usuario.tipo
				@usuarioe= Usuarioentidad.where(usuario_id: @usuario.id).take
				@entidad= Entidad.find(@usuarioe.entidad_id)
					if @usuario.activo==true
						if @usuario.ldap==true
							if tipo == "Docente"
								if @entidad.nombre=="tutor"
									session[:usuario_id] = @usuario.id
									@persona = Persona.where(usuario_id: session[:usuario_id]).take
									session[:nombre_usuario] = @persona.nombres
									session[:tutor] = true
									session[:instructor] = false
									session[:entidad] = false
									flash[:success] = "Bienvenido! " + @persona.nombres
									puts "******"
									puts "El usuario se autentico correctamente y es tutor"
									puts "******"
									redirect_to controller:"iniciotutor", action: "index"
								else
									if @entidad.nombre=="instructor"
										session[:usuario_id]= @usuario.id
										@persona = Persona.where(usuario_id: session[:usuario_id]).take
										session[:nombre_usuario] = @persona.nombres
										session[:tutor]= false
										session[:instructor]= true
										session[:entidad]= false
										flash[:success] = "Bienvenido! " + @persona.nombres
										puts "El usuario se autentico correctamente y es instructor"
										redirect_to controller:"inicioinstructor", action: "index"
									end
								end
							else
								if tipo=="Institucional"
									#ver si es necesario comparar el nombre del ldap con la bd local
									session[:usuario_id]= @usuario.id
									session[:tutor]= false
									session[:instructor]= false
									session[:entidad]= true
									session[:entidad_id] = @entidad.id
									puts (session[:entidad_id])
									session[:nombre_usuario] = @entidad.nombre
									puts "El usuario se autentico correctamente y es una entidad"
									redirect_to controller:"inicioentidad", action: "index"
								else
									puts "No soy ni docente ni Institucional"
									flash[:mensaje] = 'Su contraseña o correo electrónico es incorrecto.'
									redirect_to controller:"forminst", action: "index"
								end
							end
						else
							puts'--------'
							puts @usuario.email
							puts correo
							puts'--------'
							if @usuario.email == correo
								if @usuario.password == clave
									@usuarioe= Usuarioentidad.where(usuario_id: @usuario.id).take
									@entidad= Entidad.find(@usuarioe.entidad_id)
									if tipo=="Secretaria"
										if @entidad.nombre=="Consejo de Escuela de Computación"
											session[:usuario_id]= @usuario.id
											@persona = Persona.where(usuario_id: session[:usuario_id]).take
											session[:nombre_usuario] = @persona.nombres.titleize+' '+@persona.apellidos.titleize
											session[:tutor]= false
											session[:instructor]= false
											session[:entidad]= true
											flash[:success]= "Bienvenido! " + session[:nombre_usuario] = @persona.nombres.titleize+' '+@persona.apellidos.titleize
											puts "El usuario se autentico correctamente y es instructor"
											redirect_to controller:"secretarias", action: "index"
										end
									else
										if @entidad.nombre=="tutor"
											session[:usuario_id]= @usuario.id
											@persona = Persona.where(usuario_id: session[:usuario_id]).take
											session[:nombre_usuario] = @persona.nombres.titleize+' '+@persona.apellidos.titleize
											session[:tutor]= true
											session[:instructor]= false
											session[:entidad]= false
											flash[:success]= "Bienvenido! " + session[:nombre_usuario] = @persona.nombres.titleize+' '+@persona.apellidos.titleize
											puts "El usuario se autentico correctamente y es un tutor"
											redirect_to controller:"iniciotutor", action: "index"
										else
											if @entidad.nombre="instructor"
												session[:usuario_id] = @usuario.id
												@persona = Persona.where(usuario_id: session[:usuario_id]).take
												session[:nombre_usuario] = @persona.nombres.titleize+' '+@persona.apellidos.titleize
												session[:tutor]= false
												session[:instructor]= true
												session[:entidad]= false
												puts "El usuario se autentico correctamente y es un instructoraa"
												flash[:success]= "Bienvenido! " + session[:nombre_usuario] = @persona.nombres.titleize+' '+@persona.apellidos.titleize
												redirect_to controller:"inicioinstructor", action: "index"
											else
												session[:usuario_id]= @usuario.id
												@persona = Persona.where(usuario_id: session[:usuario_id]).take
												session[:nombre_usuario] = @persona.nombres.titleize+' '+@persona.apellidos.titleize
												session[:tutor]= false
												session[:instructor]= false
												session[:entidad]= true
												flash[:success]= "Bienvenido! " + session[:nombre_usuario] = @persona.nombres.titleize+' '+@persona.apellidos.titleize

												puts "El usuario se autentico correctamente y es una entidad"
												redirect_to controller:"forminst", action: "index"
											end
										end
									end
								else
									flash[:danger]="Su usuario o contraseña son incorrectas"
									puts "No se autentico debido a que la contraseña es incorrecta"
									render 'index'
								end
							else
								flash[:danger]="Su usuario o contraseña son incorrectas"
								puts "No se autentico debido a que el correo es incorrecto"
								render 'index'
							end
						end
					else
						flash[:danger]= "El usuario no está activo en el sistema"
						puts "El usuario no está activo"
						render 'index'
					end
				else
					puts "La persona no está registrada en la BD local"
					flash[:danger]= "El usuario o la contraseña son incorrectas"
					render 'index'
				end
			else
				#ESTO LO COLOCARE CABLEADO MIENTRASTANTO
				if correo == 'secretaria.uno' && clave == 'secretaria'
					@usuario= Usuario.where(user: correo).take
					session[:usuario_id] = @usuario.id
					@persona = Persona.where(usuario_id: session[:usuario_id]).take
					session[:nombre_usuario] = @persona.nombres.titleize+' '+@persona.apellidos.titleize
					session[:tutor]= false
					session[:instructor]= false
					session[:entidad]= false
					puts "El usuario se autentico correctamente y es una secretaria"
					redirect_to controller:"secretarias", action: "index"
				else
				##

				puts "La persona no está registrada en el ldap1"
				flash[:danger]= "El usuario o la contraseña son incorrectas"
				render "index"
				end
			end
		else
			puts "La persona no está registrada en el ldap2"
			flash[:danger]= "El usuario o la contraseña son incorrectas"
			render "index"
		end
	end


end
