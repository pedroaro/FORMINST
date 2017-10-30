class ForminstController < ApplicationController
	require 'net-ldap'
	require 'pry'
	require 'digest/sha1'

	layout 'ec_aplanes'

	#Página Principal
	def index
		reset_session
	end

	#Iniciar Sesión
	def autenticar

		#Conectar con el servidor ldap
		ldap= Net::LDAP.new(:host=>"ciens.ucv.ve",:port=>389, :auth=>{:method=> :simple, :username=>"cn=vmail,dc=ciens,dc=ucv,dc=ve", :password => "Gu4B37hpi5mgdJzkucj4OoszKYoPG1"})
		correo= params[:correo] # se toma el valor correo del ususario
		clave= params[:password] # se toma el valor password del usuario

		#Si es un Administrados
		if correo == "Administrador" && params[:password]=="1"

			session[:usuario_id] = "-2552" #número de usuario para el administrador (usado para no ingresar al modulo con el link)
			session[:nombre_usuario] = "Administrador" #usado para no ingresar al modulo con el link
			session[:administrador] = true
			session[:tutor] = false
			session[:instructor] = false
			session[:entidad] = false
			flash[:success] = "Bienvenido! Administrador"
			redirect_to controller:"administrador", action: "index" #Mostrar el modulo del administrador

		elsif correo!=nil && correo!="" && clave!=nil && clave!="" #verificar que el correo no sea nulo
		result = ldap.bind_as(:base => "dc=ciens, dc=ucv, dc=ve", :filter => "(uid=#{correo})", :password => clave) #Se busca el usuario en el ldap
		@usuario= Usuario.where(user: correo).take #buscar el usuario en la base de datos
			if @usuario #Si el usuario esta registrado
	      		tipo=@usuario.tipo #Guardar el tipo de usuario "Secretaria, Entidad, Vista(No poder modificar en la entidad), tutor e instructor"
				@usuarioe= Usuarioentidad.where(usuario_id: @usuario.id).take
				@entidad= Entidad.find(@usuarioe.entidad_id)
				if @usuario.activo==true #Sber si el usuario no esta bloqueado
					if @usuario.ldap==true && !result.blank? #si el usuario se encuentra en el ldap entonces
						@usuario.password = Digest::SHA1.hexdigest(clave) #Se encripta la clave del usuario para almacenarlo en la base de datos (se usa cuando no funciona el ldap)
						@usuario.save
						#segun el usuario se muestra su modulo y se almacenan los datos de las sesiones
						if tipo=="Secretaria"
							session[:usuario_id]= @usuario.id
							@persona = Persona.where(usuario_id: session[:usuario_id]).take
							session[:nombre_usuario] = @persona.nombres.titleize+' '+@persona.apellidos.titleize
							session[:administrador] = false
							session[:tutor]= false
							session[:instructor]= false
							session[:entidad]= true
							flash[:success]= "Bienvenido! " + session[:nombre_usuario] = @persona.nombres.titleize+' '+@persona.apellidos.titleize
							redirect_to controller:"secretarias", action: "index"
						elsif tipo == "Docente"
							if @entidad.nombre=="tutor"
								session[:usuario_id]= @usuario.id
								@persona = Persona.where(usuario_id: session[:usuario_id]).take
								session[:nombre_usuario] = @persona.nombres.titleize+' '+@persona.apellidos.titleize
								session[:administrador] = false
								session[:tutor]= true
								session[:instructor]= false
								session[:entidad]= false
								flash[:success]= "Bienvenido! " + session[:nombre_usuario] = @persona.nombres.titleize+' '+@persona.apellidos.titleize
								redirect_to controller:"iniciotutor", action: "index"
							elsif @entidad.nombre=="instructor"
								session[:usuario_id] = @usuario.id
								@persona = Persona.where(usuario_id: session[:usuario_id]).take
								session[:nombre_usuario] = @persona.nombres.titleize+' '+@persona.apellidos.titleize
								session[:administrador] = false
								session[:tutor]= false
								session[:instructor]= true
								session[:entidad]= false
								flash[:success]= "Bienvenido! " + session[:nombre_usuario] = @persona.nombres.titleize+' '+@persona.apellidos.titleize
								redirect_to controller:"inicioinstructor", action: "index"
							end
						else
							if tipo=="Institucional" || tipo=="Vista"
								session[:usuario_id]= @usuario.id
								@persona = Persona.where(usuario_id: session[:usuario_id]).take
								session[:nombre_usuario] = @persona.nombres.titleize+' '+@persona.apellidos.titleize
								session[:administrador] = false
								session[:tutor]= false
								session[:instructor]= false
								session[:entidad]= true
								flash[:success]= "Bienvenido! " + session[:nombre_usuario] = @persona.nombres.titleize+' '+@persona.apellidos.titleize

								redirect_to controller:"forminst", action: "index"
							else
								flash.now[:mensaje] = 'Su contraseña o correo electrónico es incorrecto.'
								redirect_to controller:"forminst", action: "index"
							end
						end
					else #en caso de no funcionar el ldap o de no econtrase el usuario en el mismo
						clave = Digest::SHA1.hexdigest(clave) #se encripta la clave resivida por el usuario para su posterior comparación
						if @usuario.email == correo #si el correo se encuentra registrado
							if @usuario.password == clave #y la clave es la misma
								@usuarioe= Usuarioentidad.where(usuario_id: @usuario.id).take
								@entidad= Entidad.find(@usuarioe.entidad_id)
								#segun el usuario se muestra su modulo y se almacenan los datos de las sesiones
								if tipo=="Secretaria"
									session[:usuario_id]= @usuario.id
									@persona = Persona.where(usuario_id: session[:usuario_id]).take
									session[:nombre_usuario] = @persona.nombres.titleize+' '+@persona.apellidos.titleize
									session[:administrador] = false
									session[:tutor]= false
									session[:instructor]= false
									session[:entidad]= true
									flash[:success]= "Bienvenido! " + session[:nombre_usuario] = @persona.nombres.titleize+' '+@persona.apellidos.titleize
									redirect_to controller:"secretarias", action: "index"
								elsif tipo == "Docente"
									if @entidad.nombre=="tutor"
										session[:usuario_id]= @usuario.id
										@persona = Persona.where(usuario_id: session[:usuario_id]).take
										session[:nombre_usuario] = @persona.nombres.titleize+' '+@persona.apellidos.titleize
										session[:administrador] = false
										session[:tutor]= true
										session[:instructor]= false
										session[:entidad]= false
										flash[:success]= "Bienvenido! " + session[:nombre_usuario] = @persona.nombres.titleize+' '+@persona.apellidos.titleize
										redirect_to controller:"iniciotutor", action: "index"
									else
										if @entidad.nombre="instructor"
											session[:usuario_id] = @usuario.id
											@persona = Persona.where(usuario_id: session[:usuario_id]).take
											session[:nombre_usuario] = @persona.nombres.titleize+' '+@persona.apellidos.titleize
											session[:administrador] = false
											session[:tutor]= false
											session[:instructor]= true
											session[:entidad]= false
											flash[:success]= "Bienvenido! " + session[:nombre_usuario] = @persona.nombres.titleize+' '+@persona.apellidos.titleize
											redirect_to controller:"inicioinstructor", action: "index"
										else
											session[:usuario_id]= @usuario.id
											@persona = Persona.where(usuario_id: session[:usuario_id]).take
											session[:nombre_usuario] = @persona.nombres.titleize+' '+@persona.apellidos.titleize
											session[:administrador] = false
											session[:tutor]= false
											session[:instructor]= false
											session[:entidad]= true
											flash[:success]= "Bienvenido! " + session[:nombre_usuario] = @persona.nombres.titleize+' '+@persona.apellidos.titleize

											redirect_to controller:"forminst", action: "index"
										end
									end
								elsif tipo == "Institucional" || tipo == "Vista"
									session[:usuario_id]= @usuario.id
									session[:administrador] = false
									session[:tutor]= false
									session[:instructor]= false
									session[:entidad]= true
									session[:entidad_id] = @entidad.id
									session[:nombre_usuario] = @entidad.nombre
									flash[:success]= "Bienvenido al " + @entidad.nombre
									redirect_to controller:"inicioentidad", action: "index"
								end
							#Autenticación Incorrecta
							else
								flash.now[:danger]="Su usuario o contraseña son incorrectas"
								render 'index'
							end
						else
							flash.now[:danger]="Su usuario o contraseña son incorrectas"
							render 'index'
						end
					end
				else
					flash.now[:danger]= "El usuario no está activo en el sistema"
					render 'index'
				end
			else
				flash[:danger]= "El usuario o la contraseña son incorrectas"
				render 'index'
			end
			
		else
			flash[:danger]= "El usuario o la contraseña son incorrectas"
			render "index"
		end
	end


end
