class AdministradorController < ApplicationController
	layout 'ly_inicio_entidad'
    def index
		session[:administrador]
		if session[:usuario_id]=="-2552" && session[:administrador] && session[:nombre_usuario]=="Administrador"
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def agregar_secretaria
		session[:administrador]
		if session[:usuario_id]=="-2552" && session[:administrador] && session[:nombre_usuario]=="Administrador"

			#Todas las Entidades
			cpentidad = Entidad.all
			cpcontador = 0
			@cpentidades = []
			@cpentidades[cpcontador] = Array.new(2) { |i|  }
			@cpentidades[cpcontador][0] =  "Seleccione una entidad"
			@cpentidades[cpcontador][1] = 0
			cpcontador = cpcontador + 1

			cpentidad.each do |entidad|
				if entidad.nombre != "tutor" && entidad.nombre != "instructor"
					@cpentidades[cpcontador] = Array.new(2) { |i|  }
					@cpentidades[cpcontador][0] =  entidad.nombre
					@cpentidades[cpcontador][1] = entidad.id
					cpcontador = cpcontador + 1
				end
			end

			#Todas las Escuelas
			cpescuela = Escuela.all
			cpcontador = 0
			@cpescuelas = []
			@cpescuelas[cpcontador] = Array.new(2) { |i|  }
			@cpescuelas[cpcontador][0] =  "Seleccione una escuela"
			@cpescuelas[cpcontador][1] = 0
			cpcontador = cpcontador + 1

			cpescuela.each do |escuela|
				if escuela.nombre != "Desconocida"
					@cpescuelas[cpcontador] = Array.new(2) { |i|  }
					@cpescuelas[cpcontador][0] =  escuela.nombre
					@cpescuelas[cpcontador][1] = escuela.id
					cpcontador = cpcontador + 1
				end
			end

		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def guardar_secretaria
		session[:administrador]
		if session[:usuario_id]=="-2552" && session[:administrador] && session[:nombre_usuario]=="Administrador"
			clave = params[:CI].to_s
			cpusuario = Usuario.new
			cpusuario.user = params[:correo]
			cpusuario.password = Digest::SHA1.hexdigest(clave)
			cpusuario.ldap = 0
			cpusuario.activo = 1
			cpusuario.tipo = "Secretaria"
			cpusuario.email = params[:correo]
			cpusuario.save

			cppersona = Persona.new
			cppersona.usuario_id = cpusuario.id
			cppersona.nombres = params[:Nombre]
			cppersona.apellidos = params[:Apellido]
			cppersona.ci = params[:CI].to_s
			cppersona.save

			cpuentidad = Usuarioentidad.new
			cpuentidad.usuario_id = cpusuario.id
			cpuentidad.entidad_id = params[:jrentidades]
			cpuentidad.id = cpusuario.id
			cpuentidad.escuela_id = params[:jrescuelas]
			cpuentidad.save

			redirect_to controller:"administrador", action: "index"
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def seleccionar_entidad
		session[:administrador]
		if session[:usuario_id]=="-2552" && session[:administrador] && session[:nombre_usuario]=="Administrador"

			#Todas las Entidades
			cpentidad = Entidad.all
			cpcontador = 0
			@cpentidades = []
			@cpentidades[cpcontador] = Array.new(2) { |i|  }
			@cpentidades[cpcontador][0] =  "Seleccione una entidad"
			@cpentidades[cpcontador][1] = 0
			cpcontador = cpcontador + 1

			cpentidad.each do |entidad|
				if entidad.nombre != "tutor" && entidad.nombre != "instructor"
					@cpentidades[cpcontador] = Array.new(2) { |i|  }
					@cpentidades[cpcontador][0] =  entidad.nombre
					@cpentidades[cpcontador][1] = entidad.id
					cpcontador = cpcontador + 1
				end
			end

		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def modificar_email
		session[:administrador]
		if session[:usuario_id]=="-2552" && session[:administrador] && session[:nombre_usuario]=="Administrador"
			@entidadId = params[:jrentidades]
			cjpUsuarios = Usuarioentidad.where(entidad_id: params[:jrentidades])
			cjpUsuarios.each do |uentidad|
				if Usuario.where(id: uentidad.usuario_id).take.tipo == "Institucional"
					$id = uentidad.usuario_id
				end
			end
			@email = Usuario.where(id: $id).take.user

		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def nuevo_participante
		session[:administrador]
		if session[:usuario_id]=="-2552" && session[:administrador] && session[:nombre_usuario]=="Administrador"
			@entidadId = params[:jrentidades]
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def seleccionar_entidad_participante
		session[:administrador]
		if session[:usuario_id]=="-2552" && session[:administrador] && session[:nombre_usuario]=="Administrador"
			#Todas las Entidades
			cpentidad = Entidad.all
			cpcontador = 0
			@cpentidades = []
			@cpentidades[cpcontador] = Array.new(2) { |i|  }
			@cpentidades[cpcontador][0] =  "Seleccione una entidad"
			@cpentidades[cpcontador][1] = 0
			cpcontador = cpcontador + 1

			cpentidad.each do |entidad|
				if entidad.nombre != "tutor" && entidad.nombre != "instructor"
					@cpentidades[cpcontador] = Array.new(2) { |i|  }
					@cpentidades[cpcontador][0] =  entidad.nombre
					@cpentidades[cpcontador][1] = entidad.id
					cpcontador = cpcontador + 1
				end
			end
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def guardar_participante
		session[:administrador]
		if session[:usuario_id]=="-2552" && session[:administrador] && session[:nombre_usuario]=="Administrador"
			envio = Aenviar.new
			envio.entidad_id = params[:jrentidades]
			envio.email = params[:email]
			envio.save
			flash[:success]= "Participante guardado con exito"
			redirect_to controller:"administrador", action: "index"
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def guardar_email
		session[:administrador]
		if session[:usuario_id]=="-2552" && session[:administrador] && session[:nombre_usuario]=="Administrador"
			
			usuario = Usuario.where(id: $id).take
			usuario.email = params[:email]
			usuario.user = params[:email]
			usuario.save
			redirect_to controller:"administrador", action: "index"
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def logout
		reset_session
		redirect_to controller: "forminst", action: "index"
	end
end
