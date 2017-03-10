class SecretariasController < ApplicationController
	layout 'ly_inicio_entidad'
	def index
		$modulo = "index"

		if session[:usuario_id]			
			@nombre = session[:nombre_usuario]
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def agregarTutor
		if session[:usuario_id]

			if $modulo != "agregarTutor"
				$cpnombre = nil
				$cpapellido = nil
				$cpci = nil
				$cpcorreo = nil
				$cptlf = nil
				$cpotlf = nil
				$cpfechanac = nil
				$cpdir = nil
				$cpgradoi = nil
				$cparea = nil
				$cpsubarea = nil
				$cpfechaconcurso = nil
				$cpjrtutores = nil
				$cpuad = nil
				$cpuai = nil
			end

			$modulo = "agregarTutor"

			@nombre = session[:nombre_usuario]
			@personas = Persona.all
			session[:personas] = @personas.as_json(only: [:usuario_id, :nombres, :apellidos])
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def guarda_tutor
		if session[:usuario_id]	

			haceralgo = "Si"

			cjprpersonas = Persona.all
			cjprpersonas.each do |personaactual|
				puts personaactual.ci
				if personaactual.ci == params[:CI].to_s
					haceralgo = "No"
				end
			end

			puts "holaaaaaaaaaaaaaaaa"
			puts haceralgo
			
			if haceralgo == "Si"

				puts params[:Nombre]
				puts params[:Apellido]
				puts params[:CI]
				puts params[:correo]
				puts params[:Tlf]
				puts params[:OTlf]
				puts params[:FechaNac]
				puts params[:Dir]
				puts params[:GradoI]
				puts params[:Area]
				puts params[:Subarea]
			
			cpSecretariaID = session[:usuario_id]
			cpSecretaria = Usuarioentidad.where(usuario_id: cpSecretariaID).take
			cpSecretariaEscuela = cpSecretaria.escuela_id

			cpusuario = Usuario.new
			cpusuario.user = params[:correo].to_s
			cpusuario.password = params[:CI].to_s
			cpusuario.ldap = 0
			cpusuario.activo = 1
			cpusuario.tipo = "Docente"
			cpusuario.email = params[:correo].to_s
			cpusuario.save

			cppersona = Persona.new
			cppersona.usuario_id = cpusuario.id
			cppersona.nombres = params[:Nombre].to_s
			cppersona.apellidos = params[:Apellido].to_s
			cppersona.fecha_nacimiento = params[:FechaNac].to_s
			cppersona.ci = params[:CI].to_s
			cppersona.telefono1 = params[:Tlf].to_s
			cppersona.telefono2 = params[:OTlf].to_s
			cppersona.direccion = params[:Dir].to_s
			cppersona.grado_instruccion = params[:GradoI].to_s
			cppersona.area = params[:Area].to_s
			cppersona.subarea = params[:Subarea].to_s
			cppersona.save

			cpuentidad = Usuarioentidad.new
			cpuentidad.usuario_id = cpusuario.id
			cpuentidad.entidad_id = 18
			cpuentidad.id = cpusuario.id
			cpuentidad.escuela_id = cpSecretariaEscuela
			cpuentidad.save

			redirect_to controller:"secretarias", action: "index"

			else
			$cpnombre = params[:Nombre]
			$cpapellido =params[:Apellido]
			$cpci = params[:CI]
			$cpcorreo = params[:correo]
			$cptlf = params[:Tlf]
			$cpotlf = params[:OTlf]
			$cpfechanac = params[:FechaNac]
			$cpdir = params[:Dir]
			$cpgradoi = params[:GradoI]
			$cparea = params[:Area]
			$cpsubarea = params[:Subarea]

			flash[:danger] = "La cedula de identidad ya existe"
			redirect_to :back

			end
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def agregarInstructor
		if session[:usuario_id]	

			if $modulo != "agregarInstructor"
				$cpnombre = nil
				$cpapellido = nil
				$cpci = nil
				$cpcorreo = nil
				$cptlf = nil
				$cpotlf = nil
				$cpfechanac = nil
				$cpdir = nil
				$cpgradoi = nil
				$cparea = nil
				$cpsubarea = nil
				$cpfechaconcurso = nil
				$cpjrtutores = nil
				$cpuad = nil
				$cpuai = nil
			end

			$modulo = "agregarInstructor"
				
			i = 1
			j = 1
			nombre = "hola"
			cpid = 1

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

			

			while i < cpcontador  do
				nombre = @cptutores[i][0]
				cpid = @cptutores[i][1]
				j = i + 1
				while j < cpcontador  do

					if @cptutores[j][0] < nombre
						@cptutores[i][0] = @cptutores[j][0]
						@cptutores[i][1] = @cptutores[j][1]
						@cptutores[j][0] = nombre
						@cptutores[j][1] = cpid
						nombre = @cptutores[i][0]
						cpid = @cptutores[i][1]
					end
	
					j +=1
				end
				i +=1
			end


		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def guarda_instructor
		if session[:usuario_id]	

			haceralgo = "Si"
				
			i = 1
			j = 1
			nombre = "hola"
			cpid = 1

			cjprpersonas = Persona.all
			cjprpersonas.each do |personaactual|
				puts personaactual.ci
				if personaactual.ci == params[:CI].to_s
					haceralgo = "No"
				end
			end

			puts "holaaaaaaaaaaaaaaaa"
			puts haceralgo
			
			if haceralgo == "Si"	

				if params[:JRTutores].to_s != "0"

					cpSecretariaID = session[:usuario_id]
					cpSecretaria = Usuarioentidad.where(usuario_id: cpSecretariaID).take
					cpSecretariaEscuela = cpSecretaria.escuela_id

					cpusuario = Usuario.new
					cpusuario.user = params[:correo]
					cpusuario.password = params[:CI].to_s
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
					cppersona.ci = params[:CI].to_s
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

					$cpnombre = params[:Nombre]
					$cpapellido =params[:Apellido]
					$cpci = params[:CI]
					$cpcorreo = params[:correo]
					$cptlf = params[:Tlf]
					$cpotlf = params[:OTlf]
					$cpfechanac = params[:FechaNac]
					$cpdir = params[:Dir]
					$cpgradoi = params[:GradoI]
					$cparea = params[:Area]
					$cpsubarea = params[:Subarea]
					$cpfechaconcurso = params[:FechaConcurso]
					$cpjrtutores = params[:JRTutores]
					$cpuad = params[:UAD]
					$cpuai = params[:UAI]
					flash[:danger] = "Seleccione un Tutor"
					redirect_to :back

				end

			else


				$cpnombre = params[:Nombre]
				$cpapellido =params[:Apellido]
				$cpci = params[:CI]
				$cpcorreo = params[:correo]
				$cptlf = params[:Tlf]
				$cpotlf = params[:OTlf]
				$cpfechanac = params[:FechaNac]
				$cpdir = params[:Dir]
				$cpgradoi = params[:GradoI]
				$cparea = params[:Area]
				$cpsubarea = params[:Subarea]
				$cpfechaconcurso = params[:FechaConcurso]
				$cpjrtutores = params[:JRTutores]
				$cpuad = params[:UAD]
				$cpuai = params[:UAI]
				flash[:danger] = "La cedula de identidad ya existe"
				redirect_to :back

			end

		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def modificarInstructor
		if session[:usuario_id]	
				
			if $modulo != "modificarInstructor"
				$cpnombre = nil
				$cpapellido = nil
				$cpci = nil
				$cpcorreo = nil
				$cptlf = nil
				$cpotlf = nil
				$cpfechanac = nil
				$cpdir = nil
				$cpgradoi = nil
				$cparea = nil
				$cpsubarea = nil
				$cpfechaconcurso = nil
				$cpjrtutores = nil
				$cpuad = nil
				$cpuai = nil
			end

			$modulo = "modificarInstructor"

			i = 1
			j = 1
			nombre = "hola"
			cpid = 1
			@nombre = session[:nombre_usuario]
			@personas = Persona.all
			session[:personas] = @personas.as_json(only: [:usuario_id, :nombres, :apellidos])
			cpSecretariaID = session[:usuario_id]
			cpSecretaria = Usuarioentidad.where(usuario_id: cpSecretariaID).take
			cpSecretariaEscuela = cpSecretaria.escuela_id

			uentidad = Usuarioentidad.where(escuela_id: cpSecretariaEscuela, entidad_id: 19)
			cpcontador = 0
			cpaux = ['var1', 0]
			@cptutores = []
			@cptutores[cpcontador] = Array.new(2) { |i|  }
			@cptutores[cpcontador][0] =  "Seleccione un instructor"
			@cptutores[cpcontador][1] = 0
			cpcontador = cpcontador + 1

			uentidad.each do |usuarioentidad|
				cppersona = Persona.find_by usuario_id: usuarioentidad.usuario_id
				@cptutores[cpcontador] = Array.new(2) { |i|  }
				@cptutores[cpcontador][0] =  cppersona.nombres
				@cptutores[cpcontador][1] = usuarioentidad.usuario_id
				cpcontador = cpcontador + 1
			end

			

			while i < cpcontador  do
				nombre = @cptutores[i][0]
				cpid = @cptutores[i][1]
				j = i + 1
				while j < cpcontador  do

					if @cptutores[j][0] < nombre
						@cptutores[i][0] = @cptutores[j][0]
						@cptutores[i][1] = @cptutores[j][1]
						@cptutores[j][0] = nombre
						@cptutores[j][1] = cpid
						nombre = @cptutores[i][0]
						cpid = @cptutores[i][1]
					end
	
					j +=1
				end
				i +=1
			end



		else
			redirect_to controller:"forminst", action: "index"
		end
	end


	def modificarInstructor2
		if session[:usuario_id]

			if params[:JRTutores].to_s != "0"


				$id_tutor_seleccionado = params[:JRTutores]
				cppersona = Persona.find_by usuario_id: params[:JRTutores]
				cpusuario = Usuario.find_by id: params[:JRTutores]
				cpuentidad = Usuarioentidad.find_by usuario_id: params[:JRTutores]
				cpplanformacion = Planformacion.find_by instructor_id: params[:JRTutores]

				$cpnombre = cppersona.nombres
				$cpapellido = cppersona.apellidos
				$cpci = cppersona.ci
				$cpcorreo = cpusuario.email
				$cptlf = cppersona.telefono1
				$cpotlf = cppersona.telefono2
				$cpfechanac = cppersona.fecha_nacimiento
				$cpdir = cppersona.direccion
				$cpgradoi = cppersona.grado_instruccion
				$cparea = cppersona.area
				$cpsubarea = cppersona.subarea
				$cpfechaconcurso = cpplanformacion.fecha_inicio
				$cpuad = cpplanformacion.adscripcion_docencia
				$cpuai = cpplanformacion.adscripcion_investigacion

			else

				flash[:danger] = "Seleccione un Instructor"
				redirect_to :back

			end

		else
			redirect_to controller:"forminst", action: "index"
		end
	end


	def guarda_instructor_modificado
		if session[:usuario_id]	

				puts params[:Nombre]
				puts params[:Apellido]
				puts params[:CI]
				puts params[:correo]
				puts params[:Tlf]
				puts params[:OTlf]
				puts params[:FechaNac]
				puts params[:Dir]
				puts params[:GradoI]
				puts params[:Area]
				puts params[:Subarea]

			cpusuario = Usuario.find_by id: $id_tutor_seleccionado
			cpusuario.user = params[:correo].to_s
			cpusuario.password = params[:CI].to_s
			cpusuario.email = params[:correo].to_s
			cpusuario.save

			cppersona = Persona.find_by usuario_id: $id_tutor_seleccionado
			cppersona.nombres = params[:Nombre].to_s
			cppersona.apellidos = params[:Apellido].to_s
			cppersona.fecha_nacimiento = params[:FechaNac].to_s
			cppersona.ci = params[:CI].to_s
			cppersona.telefono1 = params[:Tlf].to_s
			cppersona.telefono2 = params[:OTlf].to_s
			cppersona.direccion = params[:Dir].to_s
			cppersona.grado_instruccion = params[:GradoI].to_s
			cppersona.area = params[:Area].to_s
			cppersona.subarea = params[:Subarea].to_s
			cppersona.save

			cpuentidad = Usuarioentidad.find_by usuario_id: $id_tutor_seleccionado
			cpuentidad.usuario_id = cpusuario.id
			cpuentidad.id = cpusuario.id
			cpuentidad.save

			cpplanformacion = Planformacion.find_by instructor_id: $id_tutor_seleccionado
			cpplanformacion.fecha_inicio = params[:FechaConcurso]
			cpplanformacion.adscripcion_docencia = params[:UAD]
			cpplanformacion.adscripcion_investigacion = params[:UAI]
			cpplanformacion.save

			cpAdecuacion = Adecuacion.find_by planformacion_id: cpplanformacion.id
			cpAdecuacion.fecha_creacion = cpplanformacion.fecha_inicio
			cpAdecuacion.save

			redirect_to controller:"secretarias", action: "index"

		else
			redirect_to controller:"forminst", action: "index"
		end
	end



	def modificarTutor
		if session[:usuario_id]	

			if $modulo != "modificarTutor"
				$cpnombre = nil
				$cpapellido = nil
				$cpci = nil
				$cpcorreo = nil
				$cptlf = nil
				$cpotlf = nil
				$cpfechanac = nil
				$cpdir = nil
				$cpgradoi = nil
				$cparea = nil
				$cpsubarea = nil
				$cpfechaconcurso = nil
				$cpjrtutores = nil
				$cpuad = nil
				$cpuai = nil
			end

			$modulo = "modificarTutor"
				
			i = 1
			j = 1
			nombre = "hola"
			cpid = 1
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

			

			while i < cpcontador  do
				nombre = @cptutores[i][0]
				cpid = @cptutores[i][1]
				j = i + 1
				while j < cpcontador  do

					if @cptutores[j][0] < nombre
						@cptutores[i][0] = @cptutores[j][0]
						@cptutores[i][1] = @cptutores[j][1]
						@cptutores[j][0] = nombre
						@cptutores[j][1] = cpid
						nombre = @cptutores[i][0]
						cpid = @cptutores[i][1]
					end
	
					j +=1
				end
				i +=1
			end

		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def modificarTutor2
		if session[:usuario_id]

			if params[:JRTutores].to_s != "0"

				$id_tutor_seleccionado = params[:JRTutores].to_s
				cppersona = Persona.find_by usuario_id: params[:JRTutores].to_s
				cpusuario = Usuario.find_by id: params[:JRTutores].to_s
				cpuentidad = Usuarioentidad.find_by usuario_id: params[:JRTutores].to_s

				$cpnombre = cppersona.nombres
				$cpapellido = cppersona.apellidos
				$cpci = cppersona.ci
				$cpcorreo = cpusuario.email
				$cptlf = cppersona.telefono1
				$cpotlf = cppersona.telefono2
				$cpfechanac = cppersona.fecha_nacimiento
				$cpdir = cppersona.direccion
				$cpgradoi = cppersona.grado_instruccion
				$cparea = cppersona.area
				$cpsubarea = cppersona.subarea

			else

				flash[:danger] = "Seleccione un Tutor"
				redirect_to :back

			end


		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def guarda_tutor_modificado
		if session[:usuario_id]	

				puts params[:Nombre]
				puts params[:Apellido]
				puts params[:CI]
				puts params[:correo]
				puts params[:Tlf]
				puts params[:OTlf]
				puts params[:FechaNac]
				puts params[:Dir]
				puts params[:GradoI]
				puts params[:Area]
				puts params[:Subarea]

			cpusuario = Usuario.find_by id: $id_tutor_seleccionado
			cpusuario.user = params[:correo].to_s
			cpusuario.password = params[:CI].to_s
			cpusuario.email = params[:correo].to_s
			cpusuario.save

			cppersona = Persona.find_by usuario_id: $id_tutor_seleccionado
			cppersona.nombres = params[:Nombre].to_s
			cppersona.apellidos = params[:Apellido].to_s
			cppersona.fecha_nacimiento = params[:FechaNac].to_s
			cppersona.ci = params[:CI].to_s
			cppersona.telefono1 = params[:Tlf].to_s
			cppersona.telefono2 = params[:OTlf].to_s
			cppersona.direccion = params[:Dir].to_s
			cppersona.grado_instruccion = params[:GradoI].to_s
			cppersona.area = params[:Area].to_s
			cppersona.subarea = params[:Subarea].to_s
			cppersona.save

			cpuentidad = Usuarioentidad.find_by usuario_id: $id_tutor_seleccionado
			cpuentidad.usuario_id = cpusuario.id
			cpuentidad.id = cpusuario.id
			cpuentidad.save

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


