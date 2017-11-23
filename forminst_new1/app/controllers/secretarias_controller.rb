class SecretariasController < ApplicationController
	require 'digest/sha1'
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

			cpSecretariaID = session[:usuario_id]
			cpSecretaria = Usuarioentidad.where(usuario_id: cpSecretariaID).take
			cpSecretariaEscuela = cpSecretaria.escuela_id
			uentidad = Departamento.where(escuela_id: cpSecretariaEscuela)
			cpcontador = 0
			@departamentos = []
			@departamentos[cpcontador] = Array.new(2) { |i|  }
			@departamentos[cpcontador][0] =  "Seleccione un Departamento"
			@departamentos[cpcontador][1] = 0
			cpcontador = cpcontador + 1

			uentidad.each do |usuarioentidad|
				@departamentos[cpcontador] = Array.new(2) { |i|  }
				@departamentos[cpcontador][0] = usuarioentidad.nombre
				@departamentos[cpcontador][1] = usuarioentidad.id
				cpcontador = cpcontador + 1
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

			cjprpersonas = Persona.where(ci: params[:CI]).take
			if !cjprpersonas.blank?
				haceralgo = "No"
			end

			cjprpersonas = Usuario.where(email: params[:correo]).take
			if !cjprpersonas.blank?
				haceralgo = "No"
			end

			cjprpersonas = Usuario.where(user: params[:correo]).take
			if !cjprpersonas.blank?
				haceralgo = "No"
			end
			
			if haceralgo == "Si"
			
				if params[:depto].to_i != 0
					cpSecretariaID = session[:usuario_id]
					cpSecretaria = Usuarioentidad.where(usuario_id: cpSecretariaID).take
					cpSecretariaEscuela = cpSecretaria.escuela_id

					cpusuario = Usuario.new
					cpusuario.user = params[:correo].to_s
					cpusuario.password = Digest::SHA1.hexdigest(params[:CI])
					cpusuario.ldap = 1
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
					cpuentidad.departamento_id = params[:depto].to_i
					cpuentidad.save

					notific = Notificacion.new
			        notific.instructor_id = nil
			        notific.tutor_id = cpusuario.id
			        notific.adecuacion_id = nil
			        notific.informe_id = nil
			        notific.actual = 1
			        notificacionfecha = Date.current.to_s 
		        	notific.mensaje = "[" + notificacionfecha + "] ¡Bienvenido a FORMINST! Se ha creado su perfil de Tutor."
		        	notific.save
					remitente3 = Usuario.where(id: notific.tutor_id).take
					ActionCorreo.creacion_de_tutor(remitente3, notific.mensaje).deliver
		        	flash[:success] = "Se ha creado el tutor " + cppersona.nombres.to_s.split.map(&:capitalize).join(' ') + " " + cppersona.apellidos.to_s.split.map(&:capitalize).join(' ') + " de manera exitosa"
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

					flash[:danger] = "Debe selecionar un departamento"
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

				flash[:danger] = "La cedula de identidad o el correo ya existe"
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

			deptos = Departamento.where(escuela_id: cpSecretariaEscuela)
			cpcontador1 = 0
			@departamentos = []
			@departamentos[cpcontador1] = Array.new(2) { |i|  }
			@departamentos[cpcontador1][0] =  "Seleccione un Departamento"
			@departamentos[cpcontador1][1] = 0
			cpcontador1 = cpcontador1 + 1

			deptos.each do |usuarioentidad|
				@departamentos[cpcontador1] = Array.new(2) { |i|  }
				@departamentos[cpcontador1][0] = usuarioentidad.nombre
				@departamentos[cpcontador1][1] = usuarioentidad.id
				cpcontador1 = cpcontador1 + 1
			end

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
				@cptutores[cpcontador][0] = cppersona.nombres.to_s.split.map(&:capitalize).join(' ') + " " + cppersona.apellidos.to_s.split.map(&:capitalize).join(' ')
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

			cjprpersonas = Persona.where(ci: params[:CI]).take
			if !cjprpersonas.blank?
				haceralgo = "No"
			end

			cjprpersonas = Usuario.where(email: params[:correo]).take
			if !cjprpersonas.blank?
				haceralgo = "No"
			end

			cjprpersonas = Usuario.where(user: params[:correo]).take
			if !cjprpersonas.blank?
				haceralgo = "No"
			end

			
			if haceralgo == "Si"	
				if params[:JRTutores].to_s != "0" && params[:depto].to_i != 0
					profenti = Usuarioentidad.where(usuario_id: params[:JRTutores]).take
					if profenti.departamento_id == params[:depto].to_i
						cpelAno = params[:FechaConcurso][0..3]
						cpanoIncrementado = cpelAno.to_i + 2
						cpGuardar = cpanoIncrementado.to_s + params[:FechaConcurso][4..params[:FechaConcurso].mb_chars.length]

						cpSecretariaID = session[:usuario_id]
						cpSecretaria = Usuarioentidad.where(usuario_id: cpSecretariaID).take
						cpSecretariaEscuela = cpSecretaria.escuela_id

						cpusuario = Usuario.new
						cpusuario.user = params[:correo]
						cpusuario.password = Digest::SHA1.hexdigest(params[:CI])
						cpusuario.ldap = 1
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
						cpuentidad.departamento_id = params[:depto].to_i
						cpuentidad.save

						cpplanformacion = Planformacion.new
						cpplanformacion.fecha_inicio = params[:FechaConcurso]
						cpplanformacion.fecha_fin = cpGuardar
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
						cpAdecuacion.fecha_modificacion = cpplanformacion.fecha_inicio
						cpAdecuacion.save

						cpEstatus_Adecuacion = EstatusAdecuacion.new
						cpEstatus_Adecuacion.adecuacion_id = cpAdecuacion.id
						cpEstatus_Adecuacion.fecha = Date.current.to_s
						cpEstatus_Adecuacion.estatus_id = 6
						cpEstatus_Adecuacion.actual = 1
						cpEstatus_Adecuacion.save

						cpinstructortutor = Instructortutor.where(instructor_id: cpplanformacion.instructor_id, tutor_id: params[:JRTutores]).take
						if cpinstructortutor.blank?
							cpinstructortutor = Instructortutor.new
							cpinstructortutor.tutor_id = params[:JRTutores]
							cpinstructortutor.instructor_id = cpplanformacion.instructor_id
							cpinstructortutor.actual = 1
							cpinstructortutor.fecha_inicio = params[:FechaConcurso]
						else
							cpinstructortutor.actual = 1
						end
						cpinstructortutor.save
						notific = Notificacion.new
				        notific.instructor_id = cpusuario.id
				        notific.tutor_id = params[:JRTutores]
				        profe = Persona.where(usuario_id: params[:JRTutores]).take
				        adecc = Adecuacion.where(planformacion_id: cpAdecuacion.planformacion_id).take
				        plan = Planformacion.where(id: cpAdecuacion.planformacion_id).take
				        notific.adecuacion_id = adecc.id
				        notific.informe_id = nil
				        notific.actual = 1
				        notificacionfecha = Date.current.to_s 
			        	notific.mensaje = "[" + notificacionfecha + "] Se le ha asignado el Plan formación de " + cppersona.nombres.to_s.split.map(&:capitalize).join(' ') + " " + cppersona.apellidos.to_s.split.map(&:capitalize).join(' ') + ", recuerde crear la adecuación correspondiente y enviarla."
			        	notific.save
			        	notific2 = Notificacion.new
				        notific2.instructor_id = cpusuario.id
				        notific2.tutor_id = params[:JRTutores]
				        notific2.adecuacion_id = adecc.id
				        notific2.informe_id = nil
				        notific2.actual = 2
				        notificacionfecha = Date.current.to_s 
			        	notific2.mensaje = "[" + notificacionfecha + "] ¡Bienvenido a FORMINST! Se le ha asignado a  " + profe.nombres.to_s.split.map(&:capitalize).join(' ') + " " + profe.apellidos.to_s.split.map(&:capitalize).join(' ') + " como tutor de su Plan de formación."
			        	notific2.save
						remitente3 = Usuario.where(id: notific.tutor_id).take
						ActionCorreo.creacion_de_instructor(remitente3, notific.mensaje,1).deliver
						remitente2 = Usuario.where(id: plan.instructor_id).take
						ActionCorreo.creacion_de_instructor(remitente2, notific2.mensaje,0).deliver
			        	flash[:success] = "Se ha creado el instructor " + cppersona.nombres.to_s.split.map(&:capitalize).join(' ') + " " + cppersona.apellidos.to_s.split.map(&:capitalize).join(' ') + " de manera exitosa"
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
						flash[:danger] = "El tutor debe pertenecer al mismo departamento del instructor"
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
					flash[:danger] = "Seleccione Departamento y Tutor"
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
				flash[:danger] = "La cedula de identidad o el correo ya existe"
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
			@ver = params[:ver]
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
				@cptutores[cpcontador][0] =  cppersona.nombres.to_s.split.map(&:capitalize).join(' ') + " " + cppersona.apellidos.to_s.split.map(&:capitalize).join(' ')
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
				@ver = params[:ver]

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
					if usuarioentidad.usuario_id != cpplanformacion.tutor_id
						ccppersona = Persona.find_by usuario_id: usuarioentidad.usuario_id
						@cptutores[cpcontador] = Array.new(2) { |i|  }
						@cptutores[cpcontador][0] =  ccppersona.nombres
						@cptutores[cpcontador][1] = usuarioentidad.usuario_id
						cpcontador = cpcontador + 1
					end
				end

				#informacion
				@tutoreDeInstructor = Persona.where(usuario_id: cpplanformacion.tutor_id).take
				@tutoreDeInstructorUsu = Usuario.where(id: cpplanformacion.tutor_id).take

				

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

				$cpnombre = cppersona.nombres
				$cpapellido = cppersona.apellidos
				$cpci = cppersona.ci
				$cpcifija = cppersona.ci
				$cpcorreofijo = cpusuario.email
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


			haceralgo = "Si"
				
			i = 1
			j = 1
			nombre = "hola"
			cpid = 1

			if $cpcifija.to_s != params[:CI].to_s
				cjprpersonas = Persona.where(ci: params[:CI]).take
				if !cjprpersonas.blank?
					haceralgo = "No"
				end
			end

			if $cpcorreofijo.to_s != params[:correo].to_s
				cjprpersonas = Usuario.where(email: params[:correo]).take
				if !cjprpersonas.blank?
					haceralgo = "No"
				end

				cjprpersonas = Usuario.where(user: params[:correo]).take
				if !cjprpersonas.blank?
					haceralgo = "No"
				end
			end

			
			if haceralgo == "Si"

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
				if params[:JRTutores].to_s != "0"

						cpinstructortutor = Instructortutor.where(instructor_id: cpplanformacion.instructor_id, tutor_id: cpplanformacion.tutor_id).take

						cpinstructortutor.actual = 0
						cpinstructortutor.fecha_fin = Time.now.strftime("%Y") + "-" + Time.now.strftime("%m") + "-" + Time.now.strftime("%d")
						cpinstructortutor.save

						cpinstructortutor = Instructortutor.where(instructor_id: cpplanformacion.instructor_id, tutor_id: params[:JRTutores]).take
						if cpinstructortutor.blank?
							cpinstructortutor = Instructortutor.new
							cpinstructortutor.tutor_id = params[:JRTutores]
							cpinstructortutor.instructor_id = cpplanformacion.instructor_id
							cpinstructortutor.actual = 1
							cpinstructortutor.fecha_inicio = Time.now.strftime("%Y") + "-" + Time.now.strftime("%m") + "-" + Time.now.strftime("%d")
							cpplanformacion.tutor_id = params[:JRTutores]
						else
							cpinstructortutor.actual = 1
							cpplanformacion.tutor_id = params[:JRTutores]
						end
						cpinstructortutor.save

						pacjadecuacion = Adecuacion.where(planformacion_id: cpplanformacion.id).take
						pacjadecuacion.tutor_id = params[:JRTutores]
						pacjadecuacion.save

				end
				cpplanformacion.save

				cpAdecuacion = Adecuacion.find_by planformacion_id: cpplanformacion.id
				cpAdecuacion.fecha_creacion = cpplanformacion.fecha_inicio
				cpAdecuacion.save

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
			@ver = params[:ver]
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
				@cptutores[cpcontador][0] =  cppersona.nombres.to_s.split.map(&:capitalize).join(' ') + " " + cppersona.apellidos.to_s.split.map(&:capitalize).join(' ')
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
				@ver = params[:ver]

				$cpnombre = cppersona.nombres
				$cpapellido = cppersona.apellidos
				$cpci = cppersona.ci
				$cpcifija = cppersona.ci
				$cpcorreo = cpusuario.email
				$cpcorreofijo = cpusuario.email
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


			haceralgo = "Si"
				
			i = 1
			j = 1
			nombre = "hola"
			cpid = 1

			if $cpcifija.to_s != params[:CI].to_s
				cjprpersonas = Persona.where(ci: params[:CI]).take
				if !cjprpersonas.blank?
					haceralgo = "No"
				end
			end

			if $cpcorreofijo.to_s != params[:correo].to_s
				cjprpersonas = Usuario.where(email: params[:correo]).take
				if !cjprpersonas.blank?
					haceralgo = "No"
				end

				cjprpersonas = Usuario.where(user: params[:correo]).take
				if !cjprpersonas.blank?
					haceralgo = "No"
				end
			end

			
			if haceralgo == "Si"

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

			flash[:danger] = "La cedula de identidad o el correo ya existe"
			redirect_to :back

			end

		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def tutores_asignados
		if session[:usuario_id]

			@tutores_asig = Instructortutor.where(instructor_id: $id_tutor_seleccionado)

		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def logout
		reset_session
		redirect_to controller: "forminst", action: "index"
	end
end


