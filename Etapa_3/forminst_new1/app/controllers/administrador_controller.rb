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
			puts params[:Nombre]
			puts params[:Apellido]
			puts params[:CI]
			puts params[:correo]
			puts params[:escuela]
			puts params[:entidad]

			cpusuario = Usuario.new
			cpusuario.user = params[:correo]
			cpusuario.password = params[:CI].to_s
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
			cpuentidad.entidad_id = 19
			cpuentidad.id = cpusuario.id
			cpuentidad.escuela_id = cpSecretariaEscuela
			cpuentidad.save

			redirect_to controller:"administrador", action: "index"
		else
			redirect_to controller:"forminst", action: "index"
		end
	end
end
