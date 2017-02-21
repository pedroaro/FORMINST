class SecretariasController < ApplicationController
	layout 'ly_inicio_entidad'
	def index
		if session[:usuario_id]			
			@nombre = session[:nombre_usuario]
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def crearPlanes
		if session[:usuario_id]			
			@nombre = session[:nombre_usuario]
			@personas = Persona.all
			session[:personas] = @personas.as_json(only: [:usuario_id, :nombres, :apellidos])
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def guarda_tutor
		if session[:usuario_id]	
			
			cpSecretariaID = session[:usuario_id]
			cpSecretaria = Usuarioentidad.where(usuario_id: cpSecretariaID).take
			cpSecretariaEscuela = cpSecretaria.escuela_id

			cpusuario = Usuario.new
			cpusuario.user = params[:correo]
			cpusuario.password = params[:CI]
			cpusuario.ldap = 0
			cpusuario.activo = 1
			cpusuario.tipo = "Docente"
			cpusuario.email = params[:correo]
			cpusuario.save

			cppersona = Persona.new
			cppersona.usuario_id = cpusuario.id
			cppersona.nombres = params[:Nombre]
			cppersona.apellidos = params[:Apellido]
			cppersona.fecha_nacimiento = params[:FechaNac]
			cppersona.ci = params[:CI]
			cppersona.telefono1 = params[:Tlf]
			cppersona.telefono2 = params[:OTlf]
			cppersona.direccion = params[:Dir]
			cppersona.grado_instruccion = params[:GradoI]
			cppersona.area = params[:Area]
			cppersona.subarea = params[:Subarea]
			cppersona.save

			cpuentidad = Usuarioentidad.new
			cpuentidad.usuario_id = cpusuario.id
			cpuentidad.entidad_id = 18
			cpuentidad.id = cpusuario.id
			cpuentidad.escuela_id = cpSecretariaEscuela
			cpuentidad.save

			redirect_to controller:"secretarias", action: "index"
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def agregarInstructor
		if session[:usuario_id]	
				
			@nombre = session[:nombre_usuario]
			@personas = Persona.all
			session[:personas] = @personas.as_json(only: [:usuario_id, :nombres, :apellidos])
			cpSecretariaID = session[:usuario_id]
			cpSecretaria = Usuarioentidad.where(usuario_id: cpSecretariaID).take
			cpSecretariaEscuela = cpSecretaria.escuela_id

			uentidad = Usuarioentidad.where(escuela_id: cpSecretariaEscuela, entidad_id: 18)
			cpcontador = 0
			cpaux = ['var1', 0]
			@cptutores = []
			@cptutores[cpcontador] = Array.new(2) { |i|  }
			@cptutores[cpcontador][0] =  "Seleccione un tutor"
			@cptutores[cpcontador][1] = 0
			cpcontador = cpcontador + 1

			uentidad.each do |usuarioentidad|
				cppersona = Persona.find_by usuario_id: usuarioentidad.usuario_id
				@cptutores[cpcontador] = Array.new(2) { |i|  }
				@cptutores[cpcontador][0] =  cppersona.nombres
				@cptutores[cpcontador][1] = usuarioentidad.usuario_id
				cpcontador = cpcontador + 1
			end


		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def guarda_instructor
		if session[:usuario_id]	
			
			cpSecretariaID = session[:usuario_id]
			cpSecretaria = Usuarioentidad.where(usuario_id: cpSecretariaID).take
			cpSecretariaEscuela = cpSecretaria.escuela_id

			cpusuario = Usuario.new
			cpusuario.user = params[:correo]
			cpusuario.password = params[:CI]
			cpusuario.ldap = 0
			cpusuario.activo = 1
			cpusuario.tipo = "Docente"
			cpusuario.email = params[:correo]
			cpusuario.save

			cppersona = Persona.new
			cppersona.usuario_id = cpusuario.id
			cppersona.nombres = params[:Nombre]
			cppersona.apellidos = params[:Apellido]
			cppersona.fecha_nacimiento = params[:FechaNac]
			cppersona.ci = params[:CI]
			cppersona.telefono1 = params[:Tlf]
			cppersona.telefono2 = params[:OTlf]
			cppersona.direccion = params[:Dir]
			cppersona.grado_instruccion = params[:GradoI]
			cppersona.area = params[:Area]
			cppersona.subarea = params[:Subarea]
			cppersona.save

			cpuentidad = Usuarioentidad.new
			cpuentidad.usuario_id = cpusuario.id
			cpuentidad.entidad_id = 19
			cpuentidad.id = cpusuario.id
			cpuentidad.escuela_id = cpSecretariaEscuela
			cpuentidad.save

			cpplanformacion = Planformacion.new
			cpplanformacion.fecha_inicio = params[:FechaConcurso]
			cpplanformacion.activo = 1
			cpplanformacion.instructor_id = cpusuario.id
			cpplanformacion.tutor_id = params[:JRTutores]
			cpplanformacion.adscripcion_docencia = params[:UAD]
			cpplanformacion.adscripcion_investigacion = params[:UAI]
			cpplanformacion.save

			cpAdecuacion = Adecuacion.new
			cpAdecuacion.planformacion_id = cpplanformacion.id
			cpAdecuacion.tutor_id = cpplanformacion.tutor_id
			cpAdecuacion.fecha_creacion = cpplanformacion.fecha_inicio
			cpAdecuacion.save

			cpEstatus_Adecuacion = EstatusAdecuacion.new
			cpEstatus_Adecuacion.adecuacion_id = cpAdecuacion.id
			cpEstatus_Adecuacion.fecha = Date.current.to_s
			cpEstatus_Adecuacion.estatus_id = 6
			cpEstatus_Adecuacion.actual = 1
			cpEstatus_Adecuacion.save

			redirect_to controller:"secretarias", action: "index"
		else
			redirect_to controller:"forminst", action: "index"
		end
	end


	def logout
		reset_session
		redirect_to controller: "forminst", action: "index"
	end
end


