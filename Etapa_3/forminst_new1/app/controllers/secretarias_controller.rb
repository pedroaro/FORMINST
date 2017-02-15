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
			@escuelas= [['Seleccione una escuela',0], ['Escuela de Biología',1], ['Escuela de Computación',2], ['Escuela de Física',3], ['Escuela de Geoqímica',4], ['Instituto Biología Experimental',5], ['Instituto de Ciencia y Tecnología de Alimentos',6], ['Instituto de Ciencias de la Tierra',7], ['Instituto de Zoología y Ecología Tropical',8], ['Escuela de Matemática',9], ['Escuela de Química',10], ['Consejo de Facultad',11], ['Desconocida',12]]  
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def agregarInstructor
		if session[:usuario_id]	
				
			@nombre = session[:nombre_usuario]
			@personas = Persona.all
			session[:personas] = @personas.as_json(only: [:usuario_id, :nombres, :apellidos])
			@escuelas= [['Seleccione una escuela',0], ['Escuela de Biología',1], ['Escuela de Computación',2], ['Escuela de Física',3], ['Escuela de Geoqímica',4], ['Instituto Biología Experimental',5], ['Instituto de Ciencia y Tecnología de Alimentos',6], ['Instituto de Ciencias de la Tierra',7], ['Instituto de Zoología y Ecología Tropical',8], ['Escuela de Matemática',9], ['Escuela de Química',10], ['Consejo de Facultad',11], ['Desconocida',12]] 
			@uentidad = Usuarioentidad.where(escuela_id: 2, entidad_id: 18).take
			@tutores = Usuario.find(@uentidad.usuario_id)
			puts "holaaaaaaaaaaaaaaaa"
			puts @tutores

		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def guarda_instructor
		if session[:usuario_id]	
			cpusuario = Usuario.new
			cpusuario.user = params[:correo]
			cpusuario.password = params[:CI]
			cpusuario.ldap = 0
			cpusuario.activo = 1
			cpusuario.tipo = "Docente"
			cpusuario.email = params[:correo]

			puts params[:tutor]

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

			cpuentidad = Usuarioentidad.new
			cpuentidad.usuario_id = cpusuario.id
			cpuentidad.entidad_id = 19
			cpuentidad.id = cpusuario.id
			cpuentidad.escuela_id = params[:escuela]

			redirect_to controller:"secretarias", action: "index"
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def buscarTutor
		if session[:usuario_id]		
			@personas = Usuario.joins(:persona, :usuarioentidad).where(usuarioentidad: {escuela_id: 2})
			put @personas
		else
			redirect_to controller:"forminst", action: "index"
		end
	end


	# ##ESTA FUNCION NO SE ESTA USANDO AHORITA
	# def buscarTutor
	# 	if session[:usuario_id]		
	# 		@personas = Persona.all.select("usuario_id, nombres, apellidos")

	# 		respond_to do |format|
	# 	       format.json { render :json => @personas}
	# 	    end
	# 	else
	# 		redirect_to controller:"forminst", action: "index"
	# 	end
	# end


	def logout
		reset_session
		redirect_to controller: "forminst", action: "index"
	end
end


