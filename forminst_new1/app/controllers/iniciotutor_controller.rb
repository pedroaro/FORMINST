class IniciotutorController < ApplicationController
	layout 'ly_inicio_tutor'

	def index
		session[:tutor]
		if session[:usuario_id] && session[:tutor]
			session[:adecuacion_id] = nil
			session[:plan_id] = nil
			session[:instructorName] = nil

			@nombre = session[:nombre_usuario]
			if not @nombre
				print "NO HAY USUARIO"
			end
			@notificaciones1= []
		    @notificaciones = Notificacion.where(tutor_id: session[:usuario_id]).all
		    @notificaciones.each do |notificaciones|
		        if notificaciones.actual == 1        #Caso de notificaciones del tutor
		        	@notificaciones1.push(notificaciones)
		        end
		    end
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def logout
		reset_session
		redirect_to controller: "forminst", action: "index"
	end

	def planformacions
		if session[:usuario_id] && session[:tutor]
			session[:adecuacion_id] = nil
			@persona = Persona.where(usuario_id: session[:usuario_id]).take
    		@planformacions = Planformacion.where(tutor_id: session[:usuario_id])
    		@nombreinstructor = []
			@status = []
			@cpenviado = []
			@planformacions.each do |plan|
				@person= Persona.where(usuario_id: plan.instructor_id).take
				@nombreinstructor.push(@tutor = @person.nombres.to_s.split.map(&:capitalize).join(' ') + " " + @person.apellidos.to_s.split.map(&:capitalize).join(' '))

				adecuacion = Adecuacion.where(planformacion_id: plan.id).take
				@est= EstatusAdecuacion.where(adecuacion_id: adecuacion.id, actual: 1).take
				if !@est.blank?
					if @est.estatus_id == 1
						@status.push("APROBADO POR CONSEJO DE FACULTAD")
						@cpenviado.push(1)
					elsif @est.estatus_id == 2
						@status.push("ENVIADO A CONSEJO TECNICO")
						@cpenviado.push(1)
					elsif @est.estatus_id == 3
						@status.push("ENVIADO A COMISIÓN DE INVESTIGACIÓN")
						@cpenviado.push(1)
					elsif @est.estatus_id == 4
						@status.push("ENVIADO A CONSEJO DE FACULTAD")
						@cpenviado.push(1)
					elsif @est.estatus_id == 5
						@status.push("APROBADO CON OBSERVACIONES POR CONSEJO DE FACULTAD")
						@cpenviado.push(0)
					elsif @est.estatus_id == 6
						@status.push("GUARDADO")
						@cpenviado.push(0)
					elsif @est.estatus_id == 7
						@status.push("EN REVISIÓN MENOR POR COMISIÓN DE INVESTIGACIÓN")
						@cpenviado.push(1)
					elsif @est.estatus_id == 8
						@status.push("ENVIADO A CONSEJO DE ESCUELA")
						@cpenviado.push(1)
					elsif @est.estatus_id == 9
						@status.push("RECHAZADO POR CONSEJO DE FACULTAD")
						@cpenviado.push(1)
					end
				else
    				flash.now[:danger] = "Ha ocurrido un error, adecuaciones sin estatus de envio"
				end

			end
			@nombre = session[:nombre_usuario]
			if not @nombre
				print "NO HAY USUARIO"
			end
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def prorroga
		if session[:usuario_id] && session[:tutor]
			session[:adecuacion_id] = nil
			@persona = Persona.where(usuario_id: session[:usuario_id]).take
			@nombre = session[:nombre_usuario]
			@planformacion = session[:plan_id]
			if not @planformacion
			end
			@instructorName = session[:instructorName]
			if not @instructorName
			end
			

			if not @nombre
				print "NO HAY USUARIO"
			end
		else
			redirect_to controller:"forminst", action: "index"
		end
	end
	

	def crear_adecuacion
		if session[:usuario_id] && session[:tutor]
			@planformacion = Planformacion.find(session[:plan_id])

			@ade= Adecuacion.where(planformacion_id: @planformacion.id).take

			if @ade == nil
				@persona = Persona.where(usuario_id: session[:usuario_id]).take
				@nombre = session[:nombre_usuario]
				@planformacion = session[:plan_id]
				@instructorName = session[:instructorName]
							
				if not @nombre
					print "NO HAY USUARIO"
				end
			else
				flash[:danger]= "No puede crear la adecuación porque ya posee una asociada para este plan de formación"
				redirect_to controller:"iniciotutor", action: "ver_detalles_adecuacion"
			end
		else
			redirect_to controller:"forminst", action: "index"
		end
	end
	def crear_adecuacion_semestre2
		if session[:usuario_id] && session[:tutor]
			@persona = Persona.where(usuario_id: session[:usuario_id]).take
			@nombre = session[:nombre_usuario]
			@planformacion = session[:plan_id]
			@instructorName = session[:instructorName]
						
			if not @nombre
				print "NO HAY USUARIO"
			end
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def crear_adecuacion_semestre3
		if session[:usuario_id] && session[:tutor]
			@persona = Persona.where(usuario_id: session[:usuario_id]).take
			@nombre = session[:nombre_usuario]
			@planformacion = session[:plan_id]
			@instructorName = session[:instructorName]
						
			if not @nombre
				print "NO HAY USUARIO"
			end
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def crear_adecuacion_semestre4
		if session[:usuario_id] && session[:tutor]
			@persona = Persona.where(usuario_id: session[:usuario_id]).take
			@nombre = session[:nombre_usuario]
			@planformacion = session[:plan_id]
			@instructorName = session[:instructorName]
						
			if not @nombre
				print "NO HAY USUARIO"
			end
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def ver_detalles_adecuacion
		if session[:usuario_id] && session[:tutor]
			session[:informe_id] = nil
			if !params[:plan_id].blank?
				session[:plan_id] = params[:plan_id]
			end
			if params[:editar] == 'no' 
				session[:editar]= false
			end
			@tutoresAnteriores = Instructortutor.where(instructor_id: session[:usuario_id], actual: 0)
			@nombre = session[:nombre_usuario]
			@planformacion = Planformacion.find(session[:plan_id])

			if !@planformacion.blank?
				#Ver si el informe fue rachazado
				cpInstructor = Usuario.find(@planformacion.instructor_id)
				if (cpInstructor.activo == false)
					@cpBloquear = true
				else
					@cpBloquear = false
				end
				#fin
			end

			@instructorName = Persona.where(usuario_id: @planformacion.instructor_id).take.nombres
			session[:instructorName] = @instructorName
			@instructorName = session[:instructorName]
			@modifique=false
			@cant_delete= params[:cant_delete]
			@cant_edit= params[:cant_edit]
			@cant_doc= params[:cant_docencia]
			@cant_obli= params[:cant_obligatoria]
			@cant_inv= params[:cant_investigacion]
			@cant_for= params[:cant_formacion]
			@cant_ext= params[:cant_extension]
			@cant_otr= params[:cant_otra]
			@nombre = session[:nombre_usuario]
			@instructorName = session[:instructorName]
			@plan= Planformacion.find(session[:plan_id])
			@userentidad= Usuarioentidad.where(usuario_id: @plan.instructor_id).take
			@escuela= Escuela.where(id: @userentidad.escuela_id).take
			@persona= Persona.where(usuario_id: @plan.instructor_id).take
			@usuario= Usuario.find(@plan.instructor_id)
			@cpTutor= Persona.where(usuario_id: @plan.tutor_id).take
			@cpTutorEmail= Usuario.find(@plan.tutor_id).email
			semestre= params[:semestre].to_i
			if !params[:adecuacion_id].blank?
				session[:adecuacion_id]= params[:adecuacion_id]
				@adecuacion= Adecuacion.find(session[:adecuacion_id])
			else
				@adecuacion= Adecuacion.where(planformacion_id: session[:plan_id]).take
				session[:adecuacion_id]= @adecuacion.id
			end

			@plan= Planformacion.find(session[:plan_id])
			@userentidad= Usuarioentidad.where(usuario_id: @plan.instructor_id).take
			if @userentidad.escuela_id == nil
				@userentidad.escuela_id=12
				@userentidad.save
				@escuela= Escuela.where(id: @userentidad.escuela_id).take
			else
				@escuela= Escuela.where(id: @userentidad.escuela_id).take
			end
			@instructor= Persona.where(usuario_id: @plan.instructor_id).take

			@actividadesadoc= []
			@actividadesainv= []
			@actividadesaext= []
			@actividadesafor= []
			@actividadesaotr= []



			if @cant_edit.to_i > 0
				@modifique= true
				j=0
				i=:edit.to_s+j.to_s
				@edit= params[i].to_i

				while j < @cant_edit.to_i
					@act= Actividad.find(@edit)
					tipo= @act.tipo_actividad_id

					if tipo==1
						m=:docencia.to_s+@edit.to_s
						text= params[m]
					else
						if tipo==2
							m=:investigacion.to_s+@edit.to_s
							text= params[m]
						else
							if tipo==3
								m=:extension.to_s+@edit.to_s
								text= params[m]
							else
								if tipo==4
									m=:formacion.to_s+@edit.to_s
									text= params[m]
								else
									if tipo==5
										m=:otra.to_s+@edit.to_s
										text= params[m]
									elsif tipo==7
										m=:obligatoria.to_s+@edit.to_s
										text= params[m]
									end
								end
							end
						end
					end
					@act.actividad= text
					@adecuacion.fecha_modificacion = Time.now
					@plan.fecha_modificacion = Time.now
					@plan.save
					@adecuacion.save
					@act.save
					j= j+1
					i=:edit.to_s+j.to_s
					@edit= params[i].to_i
				end
			end

			if @cant_delete.to_i > 0
				@modifique= true
				j= 0
				i=:delete.to_s+j.to_s;
				@delete = params[i].to_i
				while j < @cant_delete.to_i
					AdecuacionActividad.where(actividad_id: @delete).destroy_all
					Actividad.find(@delete).destroy
					j = j + 1
					i=:delete.to_s+j.to_s;
					@delete = params[i]
				end
			end

			j=0
			i=:nuevadoc.to_s+j.to_s
			@docencias = params[i]

			while j < @cant_doc.to_i
				@modifique= true
				if  @docencias!=nil && @docencias!=""
					a = Actividad.new
					a.tipo_actividad_id = 1
					a.actividad = @docencias
					a.save
					adac = AdecuacionActividad.new
					adac.adecuacion_id = @adecuacion.id
					adac.actividad_id = a.id
					adac.semestre = semestre
					@plan.fecha_modificacion = Time.now
					@plan.save
					@adecuacion.fecha_modificacion = Time.now
					@adecuacion.save
					adac.save
				end
				j = j + 1
				i=:nuevadoc.to_s+j.to_s;
				@docencias = params[i]
			end

			j=0
			i=:nuevaobli.to_s+j.to_s
			@obliga = params[i]

			#obligatorias
			while j < @cant_obli.to_i
				@modifique= true
				if  @obliga!=nil && @obliga!=""
					a = Actividad.new
					a.tipo_actividad_id = 7
					a.actividad = @obliga
					a.save
					adac = AdecuacionActividad.new
					adac.adecuacion_id = @adecuacion.id
					adac.actividad_id = a.id
					adac.semestre = semestre
					@plan.fecha_modificacion = Time.now
					@plan.save
					@adecuacion.fecha_modificacion = Time.now
					@adecuacion.save
					adac.save
				end
				j = j + 1
				i=:nuevaobli.to_s+j.to_s;
				@obliga = params[i]
			end

			j=0
			i=:nuevainv.to_s+j.to_s
			@invest = params[i]

			while j < @cant_inv.to_i
				@modifique= true
				if  @invest!=nil && @invest!=""
					a = Actividad.new
					a.tipo_actividad_id = 2
					a.actividad = @invest
					a.save
					adac = AdecuacionActividad.new
					adac.adecuacion_id = @adecuacion.id
					adac.actividad_id = a.id
					adac.semestre = semestre
					@plan.fecha_modificacion = Time.now
					@plan.save
					@adecuacion.fecha_modificacion = Time.now
					@adecuacion.save
					adac.save
				end
				j = j + 1
				i=:nuevainv.to_s+j.to_s;
				@invest = params[i]
			end

			j=0
			i=:nuevafor.to_s+j.to_s
			@formacion = params[i]

			while j < @cant_for.to_i
				@modifique= true
				if  @formacion!=nil && @formacion!=""
					a = Actividad.new
					a.tipo_actividad_id = 4
					a.actividad = @formacion
					a.save
					adac = AdecuacionActividad.new
					adac.adecuacion_id = @adecuacion.id
					adac.actividad_id = a.id
					adac.semestre = semestre
					@plan.fecha_modificacion = Time.now
					@plan.save
					@adecuacion.fecha_modificacion = Time.now
					@adecuacion.save
					adac.save
				end
				j = j + 1
				i=:nuevafor.to_s+j.to_s;
				@formacion = params[i]
			end

			j=0
			i=:nuevaext.to_s+j.to_s
			@extension = params[i]

			while j < @cant_ext.to_i
				@modifique= true
				if  @extension!=nil && @extension!=""
					a = Actividad.new
					a.tipo_actividad_id = 3
					a.actividad = @extension
					a.save
					adac = AdecuacionActividad.new
					adac.adecuacion_id = @adecuacion.id
					adac.actividad_id = a.id
					adac.semestre = semestre
					@plan.fecha_modificacion = Time.now
					@plan.save
					@adecuacion.fecha_modificacion = Time.now
					@adecuacion.save
					adac.save
				end
				j = j + 1
				i=:nuevaext.to_s+j.to_s;
				@extension = params[i]
			end

			j=0
			i=:nuevaotr.to_s+j.to_s
			@otra = params[i]

			while j < @cant_otr.to_i
				@modifique= true
				if  @otra!=nil && @otra!=""
					a = Actividad.new
					a.tipo_actividad_id = 5
					a.actividad = @otra
					a.save
					adac = AdecuacionActividad.new
					adac.adecuacion_id = @adecuacion.id
					adac.actividad_id = a.id
					adac.semestre = semestre
					@plan.fecha_modificacion = Time.now
					@plan.save
					@adecuacion.fecha_modificacion = Time.now
					@adecuacion.save
					adac.save
				end
				j = j + 1
				i=:nuevaotr.to_s+j.to_s;
				@otra = params[i]
			end

			if @modifique == true
				if semestre == 1
					flash[:success]= "La adecuación fue modificada y guardada correctamente"
					redirect_to controller:"iniciotutor", action: "detalles_adecuacion3"
				elsif semestre == 2
					flash[:success]= "La adecuación fue modificada y guardada correctamente"
					redirect_to controller:"iniciotutor", action: "detalles_adecuacion4"
				elsif semestre == 3
					flash[:success]= "La adecuación fue modificada y guardada correctamente"
					redirect_to controller:"iniciotutor", action: "detalles_adecuacion5"
				elsif semestre == 4
					flash[:success]= "La adecuación fue modificada y guardada correctamente"
					redirect_to controller:"iniciotutor", action: "detalles_adecuacion6"
				elsif semestre == 5
					flash[:success]= "La adecuación fue modificada y guardada correctamente"
					redirect_to controller:"iniciotutor", action: "detalles_adecuacion7"
				elsif semestre == 0
					flash[:success]= "La adecuación fue modificada y guardada correctamente"
					redirect_to controller:"iniciotutor", action: "detalles_adecuacion2"
				end
						
			end
			
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def guardar_primera_parte

		if session[:usuario_id] && session[:tutor]
			#Guardar primera parte del informe
			if !params[:firtsPart].blank?

				#Presentacion
				if params[:presentacionId].blank?
					cpActividad = Actividad.new
					cpActividad.tipo_actividad_id = 9
					cpActividad.actividad = params[:presentacion]
					cpActividad.save
					cpActividadAdecuacion = AdecuacionActividad.new
					cpActividadAdecuacion.adecuacion_id = session[:adecuacion_id]
					cpActividadAdecuacion.actividad_id = cpActividad.id
					cpActividadAdecuacion.semestre = 0
					cpActividadAdecuacion.save
				end

				# Descripción del Perfil del Ganador del concurso
				if params[:descripcionId].blank?
					cpActividad = Actividad.new
					cpActividad.tipo_actividad_id = 8
					cpActividad.actividad = params[:descripcion]
					cpActividad.save
					cpActividadAdecuacion = AdecuacionActividad.new
					cpActividadAdecuacion.adecuacion_id = session[:adecuacion_id]
					cpActividadAdecuacion.actividad_id = cpActividad.id
					cpActividadAdecuacion.semestre = 0
					cpActividadAdecuacion.save
				end

				# Docencia
				if params[:docenciaId].blank?
					cpActividad = Actividad.new
					cpActividad.tipo_actividad_id = 1
					cpActividad.actividad = params[:docencia]
					cpActividad.save
					cpActividadAdecuacion = AdecuacionActividad.new
					cpActividadAdecuacion.adecuacion_id = session[:adecuacion_id]
					cpActividadAdecuacion.actividad_id = cpActividad.id
					cpActividadAdecuacion.semestre = 0
					cpActividadAdecuacion.save
				end

				# Investigacion
				if params[:investigacionId].blank?
					cpActividad = Actividad.new
					cpActividad.tipo_actividad_id = 2
					cpActividad.actividad = params[:investigacion]
					cpActividad.save
					cpActividadAdecuacion = AdecuacionActividad.new
					cpActividadAdecuacion.adecuacion_id = session[:adecuacion_id]
					cpActividadAdecuacion.actividad_id = cpActividad.id
					cpActividadAdecuacion.semestre = 0
					cpActividadAdecuacion.save
				end

				# Formación y capacitación profesional
				if params[:formacionId].blank?
					cpActividad = Actividad.new
					cpActividad.tipo_actividad_id = 4
					cpActividad.actividad = params[:formacion]
					cpActividad.save
					cpActividadAdecuacion = AdecuacionActividad.new
					cpActividadAdecuacion.adecuacion_id = session[:adecuacion_id]
					cpActividadAdecuacion.actividad_id = cpActividad.id
					cpActividadAdecuacion.semestre = 0
					cpActividadAdecuacion.save
				end

				# Extension
				if params[:extensionId].blank?
					cpActividad = Actividad.new
					cpActividad.tipo_actividad_id = 3
					cpActividad.actividad = params[:extension]
					cpActividad.save
					cpActividadAdecuacion = AdecuacionActividad.new
					cpActividadAdecuacion.adecuacion_id = session[:adecuacion_id]
					cpActividadAdecuacion.actividad_id = cpActividad.id
					cpActividadAdecuacion.semestre = 0
					cpActividadAdecuacion.save
				end

				#Editar
				j=0
				i=:edit.to_s+j.to_s
				@edit= params[i].to_s

				while j < params[:cant_edit].to_i
					if @edit == "presentacion"
						if !params[:presentacionId].blank?
							cpActividad = Actividad.find(params[:presentacionId])
							cpActividad.actividad = params[:presentacion]
							cpActividad.save
						end
					elsif @edit == "descripcion"
						if !params[:presentacionId].blank?
							cpActividad = Actividad.find(params[:descripcionId])
							cpActividad.actividad = params[:descripcion]
							cpActividad.save
						end
					elsif @edit == "docencia"
						if !params[:presentacionId].blank?
							cpActividad = Actividad.find(params[:docenciaId])
							cpActividad.actividad = params[:docencia]
							cpActividad.save
						end
					elsif @edit == "investigacion"
						if !params[:presentacionId].blank?
							cpActividad = Actividad.find(params[:investigacionId])
							cpActividad.actividad = params[:investigacion]
							cpActividad.save
						end
					elsif @edit == "formacion"
						if !params[:presentacionId].blank?
							cpActividad = Actividad.find(params[:formacionId])
							cpActividad.actividad = params[:formacion]
							cpActividad.save
						end
					elsif @edit == "extension"
						if !params[:presentacionId].blank?
							cpActividad = Actividad.find(params[:extensionId])
							cpActividad.actividad = params[:extension]
							cpActividad.save
						end
					end

					j+=1
					i=:edit.to_s+j.to_s
					@edit= params[i].to_s
				end
			end
			redirect_to controller:"iniciotutor", action: "detalles_adecuacion2"
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def detalles_adecuacion2

		if session[:usuario_id] && session[:tutor]
			if params[:plan_id]
				@planformacion = Planformacion.find(params[:plan_id])
				session[:editar]= true
				session[:plan_id] = @planformacion.id
				@instructorName = Persona.where(usuario_id: @planformacion.instructor_id).take.nombres
				session[:instructorName] = @instructorName
				@adecuacion = Adecuacion.where(planformacion_id: session[:plan_id]).take
				session[:adecuacion_id]= @adecuacion.id
			else 
				@planformacion = Planformacion.find(session[:plan_id])
			end
			
			if !@planformacion.blank?
				#Ver si el informe fue rachazado
				cpInstructor = Usuario.find(@planformacion.instructor_id)
				if (cpInstructor.activo == false)
					@cpBloquear = true
				else
					@cpBloquear = false
				end
				#fin
			end

			@adecuacion = Adecuacion.where(planformacion_id: session[:plan_id]).take
			actividades = AdecuacionActividad.where(adecuacion_id: session[:adecuacion_id], semestre: 0)
			if !actividades.blank?
				actividades.each do |actividadAde|
					actividad = Actividad.find(actividadAde.actividad_id)
					if actividad.tipo_actividad_id == 9
						@presentacion = actividad.actividad
						@presentacionId = actividad.id
					elsif actividad.tipo_actividad_id == 8
						@descripcion = actividad.actividad
						@descripcionId = actividad.id
					elsif actividad.tipo_actividad_id == 1
						@docencia = actividad.actividad	
						@docenciaId = actividad.id
					elsif actividad.tipo_actividad_id == 2
						@investigacion = actividad.actividad
						@investigacionId = actividad.id
					elsif actividad.tipo_actividad_id == 4
						@formacion = actividad.actividad	
						@formacionId = actividad.id
					elsif actividad.tipo_actividad_id == 3
						@extension = actividad.actividad	
						@extensionId = actividad.id
					end
				end
			end

			if params[:editar] == 'no' 
				session[:editar]= false
			end
			@est= EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
			if !session[:editar] && (@est.estatus_id == 6 || @est.estatus_id == 5)
				flash.now[:info]= "Para editar la Adecuación debe seleccionar Modificar Adecuación"
			end
			
			@bool_enviado = 0
			estatus_adecuacion = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take

			if (estatus_adecuacion.estatus_id != 6 && estatus_adecuacion.estatus_id != 5 && estatus_adecuacion.estatus_id != 9)
				@bool_enviado = 1
			end
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def detalles_adecuacion3

		if session[:usuario_id] && session[:tutor]
			if params[:plan_id]
				@planformacion = Planformacion.find(params[:plan_id])
				session[:editar]= true
				session[:plan_id] = @planformacion.id
				@instructorName = Persona.where(usuario_id: @planformacion.instructor_id).take.nombres
				session[:instructorName] = @instructorName
				@adecuacion = Adecuacion.where(planformacion_id: session[:plan_id]).take
				session[:adecuacion_id]= @adecuacion.id
			else 
				@planformacion = Planformacion.find(session[:plan_id])
			end
			
			if !@planformacion.blank?
				#Ver si el informe fue rachazado
				cpInstructor = Usuario.find(@planformacion.instructor_id)
				if (cpInstructor.activo == false)
					@cpBloquear = true
				else
					@cpBloquear = false
				end
				#fin
			end

			@adecuacion = Adecuacion.where(planformacion_id: session[:plan_id]).take
			if params[:editar] == 'no' 
				session[:editar]= false
			end
			@est= EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
			if !session[:editar] && (@est.estatus_id == 6 || @est.estatus_id == 5)
				flash.now[:info]= "Para editar la Adecuación debe seleccionar Modificar Adecuación"
			end
			@adecuaciones = Adecuacion.where(planformacion_id: session[:plan_id])
			@iddoc= 'id_docencia'
			@docencia='docencia'
			@investigacion= 'investigacion'
			@formacion= 'formacion'
			@extension= 'extension'
			@otra= 'otra' 
			@nombre = session[:nombre_usuario]
			@instructorName = session[:instructorName]
			@plan= Planformacion.find(session[:plan_id])
			@actividadesadoc= []
			@actividadesainv= []
			@actividadesaext= []
			@actividadesafor= []
			@actividadesaotr= []
			@observacionesExtras= []
			@j=0
			@actividadesa= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: 1).all
			@actividadesa.each do |actade| 
				@act= Actividad.find(actade.actividad_id)
				tipo= @act.tipo_actividad_id
				if tipo==1
					@actividadesadoc.push(@act)
				else
					if tipo==2
						@actividadesainv.push(@act)
					else
						if tipo==3
							@actividadesaext.push(@act)
						else
							if tipo==4
								@actividadesafor.push(@act)
							else
								if tipo==5
									@actividadesaotr.push(@act)
								end
							end
						end
					end
				end
			end
			@actividadesa= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: 1).all
			@actividadesa.each do |actade| 
				@cpObs= ObservacionActividadAdecuacion.where(adecuacionactividad_id: actade.id).all

			    if @cpObs.blank?
			    	@observacionesExtras[actade.id]="no"
			    else

					cpBool = 0
					@cpObs.each do |probar|
						if !probar.observaciones.blank?
							cpBool = 1
						end
					end

			    	if cpBool == 0
			    		@observacionesExtras[actade.id]="no"
			    	else
			    		@observacionesExtras[actade.id]="si"
			    	end
			    end
			end
			@bool_enviado = 0
			estatus_adecuacion = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take

			if (estatus_adecuacion.estatus_id != 6 && estatus_adecuacion.estatus_id != 5 && estatus_adecuacion.estatus_id != 9)
				@bool_enviado = 1
			end
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def detalles_adecuacion4
		if session[:usuario_id] && session[:tutor]
			@iddoc= 'id_docencia'
			@docencia='docencia'
			@investigacion= 'investigacion'
			@formacion= 'formacion'
			@extension= 'extension'
			@otra= 'otra' 
			@adecuacion = Adecuacion.where(planformacion_id: session[:plan_id]).take
			@est= EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
			if !session[:editar] && (@est.estatus_id == 6 || @est.estatus_id == 5)
				flash.now[:info]= "Para editar la Adecuación debe seleccionar Modificar Adecuación"
			end
			@nombre = session[:nombre_usuario]
			@instructorName = session[:instructorName]
			@plan= Planformacion.find(session[:plan_id])
			@planformacion = Planformacion.find(session[:plan_id])
			if !@planformacion.blank?
				#Ver si el informe fue rachazado
				cpInstructor = Usuario.find(@planformacion.instructor_id)
				if (cpInstructor.activo == false)
					@cpBloquear = true
				else
					@cpBloquear = false
				end
				#fin
			end

			@actividadesadoc= []
			@actividadesainv= []
			@actividadesaext= []
			@actividadesafor= []
			@actividadesaotr= []
			@observacionesExtras= []
			@actividadesa= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: 2).all
			@actividadesa.each do |actade| 
				@act= Actividad.find(actade.actividad_id)
				tipo= @act.tipo_actividad_id
				if tipo==1
					@actividadesadoc.push(@act)
				else
					if tipo==2
						@actividadesainv.push(@act)
					else
						if tipo==3
							@actividadesaext.push(@act)
						else
							if tipo==4
								@actividadesafor.push(@act)
							else
								if tipo==5
									@actividadesaotr.push(@act)
								end
							end
						end
					end
				end
			end
			@actividadesa= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: 2).all
			@actividadesa.each do |actade| 
				@cpObs= ObservacionActividadAdecuacion.where(adecuacionactividad_id: actade.id).all

			    if @cpObs.blank?
			    	@observacionesExtras[actade.id]="no"
			    else

					cpBool = 0
					@cpObs.each do |probar|
						if !probar.observaciones.blank?
							cpBool = 1
						end
					end

			    	if cpBool == 0
			    		@observacionesExtras[actade.id]="no"
			    	else
			    		@observacionesExtras[actade.id]="si"
			    	end
			    end
			end
			@bool_enviado = 0
			estatus_adecuacion = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take

			if (estatus_adecuacion.estatus_id != 6 && estatus_adecuacion.estatus_id != 5 && estatus_adecuacion.estatus_id != 9)
				@bool_enviado = 1
			end

		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def detalles_adecuacion5
		if session[:usuario_id] && session[:tutor]
			@iddoc= 'id_docencia'
			@docencia='docencia'
			@investigacion= 'investigacion'
			@formacion= 'formacion'
			@extension= 'extension'
			@otra= 'otra' 
			@nombre = session[:nombre_usuario]
			@instructorName = session[:instructorName]
			@plan= Planformacion.find(session[:plan_id])

			@planformacion = Planformacion.find(session[:plan_id])
			if !@planformacion.blank?
				#Ver si el informe fue rachazado
				cpInstructor = Usuario.find(@planformacion.instructor_id)
				if (cpInstructor.activo == false)
					@cpBloquear = true
				else
					@cpBloquear = false
				end
				#fin
			end

			@actividadesadoc= []
			@actividadesainv= []
			@actividadesaext= []
			@actividadesafor= []
			@actividadesaotr= []
			@observacionesExtras= []
			@adecuacion = Adecuacion.where(planformacion_id: session[:plan_id]).take
			@est= EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
			if !session[:editar] && (@est.estatus_id == 6 || @est.estatus_id == 5)
				flash.now[:info]= "Para editar la Adecuación debe seleccionar Modificar Adecuación"
			end
			@actividadesa= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: 3).all
			a= false
			b= false
			c= false
			d= false
			e= false
			@actividadesa.each do |actade| 
				@act= Actividad.find(actade.actividad_id)
				tipo= @act.tipo_actividad_id
				if tipo==1
					@actividadesadoc.push(@act)
					a = true
				else
					if tipo==2
						@actividadesainv.push(@act)
						b = true
					else
						if tipo==3
							@actividadesaext.push(@act)
							c = true
						else
							if tipo==4
								@actividadesafor.push(@act)
								d = true
							else
								if tipo==5
									@actividadesaotr.push(@act)
									e = true
								end
							end
						end
					end
				end
			end
			@actividadesa= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: 3).all
			@actividadesa.each do |actade| 
				@cpObs= ObservacionActividadAdecuacion.where(adecuacionactividad_id: actade.id).all

			    if @cpObs.blank?
			    	@observacionesExtras[actade.id]="no"
			    else

					cpBool = 0
					@cpObs.each do |probar|
						if !probar.observaciones.blank?
							cpBool = 1
						end
					end

			    	if cpBool == 0
			    		@observacionesExtras[actade.id]="no"
			    	else
			    		@observacionesExtras[actade.id]="si"
			    	end
			    end
			end
			if (a == true && b== true && c== true && d== true  && e== true)
			else 
			end
			@bool_enviado = 0
			estatus_adecuacion = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take

			if (estatus_adecuacion.estatus_id != 6 && estatus_adecuacion.estatus_id != 5 && estatus_adecuacion.estatus_id != 9)
				@bool_enviado = 1
			end
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def detalles_adecuacion6
		if session[:usuario_id] && session[:tutor]
			@iddoc= 'id_docencia'
			@docencia='docencia'
			@investigacion= 'investigacion'
			@formacion= 'formacion'
			@extension= 'extension'
			@otra= 'otra' 
			@nombre = session[:nombre_usuario]
			@instructorName = session[:instructorName]
			@plan= Planformacion.find(session[:plan_id])

			@planformacion = Planformacion.find(session[:plan_id])
			if !@planformacion.blank?
				#Ver si el informe fue rachazado
				cpInstructor = Usuario.find(@planformacion.instructor_id)
				if (cpInstructor.activo == false)
					@cpBloquear = true
				else
					@cpBloquear = false
				end
				#fin
			end

			@actividadesadoc= []
			@actividadesainv= []
			@actividadesaext= []
			@actividadesafor= []
			@actividadesaotr= []
			@observacionesExtras= []
			@adecuacion = Adecuacion.where(planformacion_id: session[:plan_id]).take
			@est= EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
			if !session[:editar] && (@est.estatus_id == 6 || @est.estatus_id == 5)
				flash.now[:info]= "Para editar la Adecuación debe seleccionar Modificar Adecuación"
			end
			@actividadesa= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: 4).all
			if @actividadesa.blank?
			end
			@actividadesa.each do |actade| 
				@act= Actividad.find(actade.actividad_id)
				tipo= @act.tipo_actividad_id
				if tipo==1
					@actividadesadoc.push(@act)
				else
					if tipo==2
						@actividadesainv.push(@act)
					else
						if tipo==3
							@actividadesaext.push(@act)
						else
							if tipo==4
								@actividadesafor.push(@act)
							else
								if tipo==5
									@actividadesaotr.push(@act)
								end
							end
						end
					end
				end
			end
			@actividadesa= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: 4).all
			@actividadesa.each do |actade| 
				@cpObs= ObservacionActividadAdecuacion.where(adecuacionactividad_id: actade.id).all

			    if @cpObs.blank?
			    	@observacionesExtras[actade.id]="no"
			    else

					cpBool = 0
					@cpObs.each do |probar|
						if !probar.observaciones.blank?
							cpBool = 1
						end
					end

			    	if cpBool == 0
			    		@observacionesExtras[actade.id]="no"
			    	else
			    		@observacionesExtras[actade.id]="si"
			    	end
			    end
			end
			@bool_enviado = 0
			estatus_adecuacion = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take

			if (estatus_adecuacion.estatus_id != 6 && estatus_adecuacion.estatus_id != 5 )
				@bool_enviado = 1
			end
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def detalles_adecuacion7
		if session[:usuario_id] && session[:tutor]
			@iddoc= 'id_docencia'
			@docencia='docencia'
			@investigacion= 'investigacion'
			@formacion= 'formacion'
			@extension= 'extension'
			@otra= 'otra' 
			@nombre = session[:nombre_usuario]
			@instructorName = session[:instructorName]
			@plan= Planformacion.find(session[:plan_id])

			@planformacion = Planformacion.find(session[:plan_id])
			if !@planformacion.blank?
				#Ver si el informe fue rachazado
				cpInstructor = Usuario.find(@planformacion.instructor_id)
				if (cpInstructor.activo == false)
					@cpBloquear = true
				else
					@cpBloquear = false
				end
				#fin
			end

			@actividadesadoc= []
			@actividadesainv= []
			@actividadesaext= []
			@actividadesafor= []
			@actividadesaotr= []
			@observacionesExtras= []
			@adecuacion = Adecuacion.where(planformacion_id: session[:plan_id]).take
			@est= EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
			if !session[:editar] && (@est.estatus_id == 6 || @est.estatus_id == 5)
				flash.now[:info]= "Para editar la Adecuación debe seleccionar Modificar Adecuación"
			end
			@actividadesa= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: 5).all
			if @actividadesa.blank?
			end
			@actividadesa.each do |actade| 
				@act= Actividad.find(actade.actividad_id)
				tipo= @act.tipo_actividad_id
				if tipo==1
					@actividadesadoc.push(@act)
				else
					if tipo==2
						@actividadesainv.push(@act)
					else
						if tipo==3
							@actividadesaext.push(@act)
						else
							if tipo==4
								@actividadesafor.push(@act)
							else
								if tipo==5
									@actividadesaotr.push(@act)
								end
							end
						end
					end
				end
			end
			@actividadesa= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: 5).all
			@actividadesa.each do |actade| 
				@cpObs= ObservacionActividadAdecuacion.where(adecuacionactividad_id: actade.id).all

			    if @cpObs.blank?
			    	@observacionesExtras[actade.id]="no"
			    else

					cpBool = 0
					@cpObs.each do |probar|
						if !probar.observaciones.blank?
							cpBool = 1
						end
					end

			    	if cpBool == 0
			    		@observacionesExtras[actade.id]="no"
			    	else
			    		@observacionesExtras[actade.id]="si"
			    	end
			    end
			end
			@bool_enviado = 0
			estatus_adecuacion = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take

			if (estatus_adecuacion.estatus_id != 6 && estatus_adecuacion.estatus_id != 5 )
				@bool_enviado = 1
			end
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def guardar_adecuacion
		if session[:usuario_id] && session[:tutor]
			semestre = params[:semestre].to_i
			cant_docencia = params[:cant_docencia]
			cant_investigacion = params[:cant_investigacion]
			cant_formacion = params[:cant_formacion]
			cant_extension = params[:cant_extension]
			cant_otra = params[:cant_otra]
			
			@persona = Persona.where(usuario_id: session[:usuario_id]).take
			@nombre = session[:nombre_usuario]
			@idtutor = session[:usuario_id]
			@planformacion = Planformacion.find(session[:plan_id])
			@ade= Adecuacion.where(planformacion_id: @planformacion.id).take
			cambio_act = EstatusAdecuacion.where(adecuacion_id: @ade.id, actual: 1).take
			if cambio_act.estatus_id != 6
				flash[:danger]= "La adecuación no puede ser modificada"
				redirect_to controller:"iniciotutor", action: "ver_detalles_adecuacion"
			elsif @ade == nil

				ad= Adecuacion.new
				ad.planformacion_id = @planformacion.id
				ad.tutor_id = @idtutor
				ad.fecha_creacion= Time.now
				ad.fecha_modificacion= Time.now
				ad.save

				est=EstatusAdecuacion.new
				est.adecuacion_id = ad.id
				est.fecha = Time.now
				est.estatus_id = 6
				est.actual = 1
				est.save
				h = 0
				
				j= 0
				i=:docencia.to_s+j.to_s;
				@docencias = params[i]

				while j < cant_docencia.to_i

					if  @docencias!=nil && @docencias!=""
						if @docencias!=nil && @docencias!=""
						end

						a = Actividad.new
						a.tipo_actividad_id = 1
						a.actividad = @docencias
						a.save

						adac = AdecuacionActividad.new
						adac.adecuacion_id = ad.id
						adac.actividad_id = a.id
						adac.semestre = semestre
						adac.save
					end
					j = j + 1
					i=:docencia.to_s+j.to_s;
					@docencias = params[i]
				end

				j= 0
				i=:investigacion.to_s+j.to_s;
				investigacion = params[i]
				while j < cant_investigacion.to_i
					if  investigacion!=nil && investigacion!=""
							
						a = Actividad.new
						a.tipo_actividad_id = 2
						a.actividad = investigacion
						a.save


						adac = AdecuacionActividad.new
						adac.adecuacion_id = ad.id
						adac.actividad_id = a.id
						adac.semestre = semestre
						adac.save

					end
					j = j + 1
					i=:investigacion.to_s+j.to_s;
					investigacion = params[i]
				end
				

				j = 0
				i=:extension.to_s+j.to_s;
				extension = params[i]
				while j < cant_extension.to_i
					if  extension!=nil && extension!=""

						a = Actividad.new
						a.tipo_actividad_id = 3
						a.actividad = extension
						a.save

						adac = AdecuacionActividad.new
						adac.adecuacion_id = ad.id
						adac.actividad_id = a.id
						adac.semestre = semestre
						adac.save


					end
					j = j + 1
					i=:extension.to_s+j.to_s;
					extension = params[i]
				end


				j = 0
				i=:formacion.to_s+j.to_s;
				formacion = params[i]
				while j < cant_formacion.to_i
					if  formacion!=nil && formacion!=""
						
						a = Actividad.new
						a.tipo_actividad_id = 4
						a.actividad = formacion
						a.save

						adac = AdecuacionActividad.new
						adac.adecuacion_id = ad.id
						adac.actividad_id = a.id
						adac.semestre = 1
						adac.save

					
					end
					j = j + 1
					i=:formacion.to_s+j.to_s;
					formacion = params[i]
				end

				j = 0
				i=:otra.to_s+j.to_s;
				otra = params[i]
				while j < cant_otra.to_i
					if  otra!=nil && otra!=""
						
						a = Actividad.new
						a.tipo_actividad_id = 5
						a.actividad = otra
						a.save

						adac = AdecuacionActividad.new
						adac.adecuacion_id = ad.id
						adac.actividad_id = a.id
						adac.semestre = semestre
						adac.save

					end
					j = j + 1
					i=:otra.to_s+j.to_s;
					otra = params[i]
				end

					flash[:success]= "La adecuación fue creada y guardada correctamente"
					redirect_to controller:"iniciotutor", action: "detalles_adecuacion3"



			else
				flash[:danger]= "La adecuación no fue creada porque ya posee una asociada para este plan de formación"
				redirect_to controller:"iniciotutor", action: "ver_detalles_adecuacion"
			end

		else
			redirect_to controller:"forminst", action: "index"
		end
		
	end

	def eliminar_adecuacion
		if session[:usuario_id] && session[:tutor]
			@adecuacion= Adecuacion.find(session[:adecuacion_id])
			@est= EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
			if @est.estatus_id == 6
	      		@documents = Document.where(adecuacion_id: session[:adecuacion_id]).all
				@actividadAde = AdecuacionActividad.where(adecuacion_id: @adecuacion.id).all
				@actividadAde.each do |actade| 
					@elimi = Actividad.where(id: actade.actividad_id).take
					@elimi.destroy
					actade.destroy
				end
				@documents.each do |documents| 
					documents.destroy
				end

				flash[:success]= "La adecuacion fue eliminada correctamente"
			else
				flash[:danger]= "No está permitido eliminar esta adecuación"
			end
			redirect_to controller:"iniciotutor", action: "ver_detalles_adecuacion"
		else 
			redirect_to controller:"forminst", action: "index"
		end
	end

	def vista_previa
		if session[:usuario_id] && session[:tutor]
			@fechaActual = Date.current.to_s
			@plan= Planformacion.find(session[:plan_id])
			

			if !@plan.blank?
				#Ver si el informe fue rachazado
				cpInstructor = Usuario.find(@plan.instructor_id)
				if (cpInstructor.activo == false)
					@cpBloquear = true
				else
					@cpBloquear = false
				end
				#fin
			end

			@fechaConcurso = @plan.fecha_inicio
			@usere= Usuarioentidad.where(usuario_id: @plan.instructor_id).take
			@escuela= Escuela.find(@usere.escuela_id)
			@adecuacion= Adecuacion.where(planformacion_id: @plan.id).take
			@adscripcion_docencia= @plan.adscripcion_docencia
			@adscripcion_investigacion= @plan.adscripcion_investigacion
			@persona= Persona.where(usuario_id: @plan.instructor_id).take
			@cpinstruccion = @persona.grado_instruccion
			@user = Usuario.find(@plan.instructor_id)
			@cpTutor= Persona.where(usuario_id: @plan.tutor_id).take
			@cpTutorEmail= Usuario.find(@plan.tutor_id).email

			@docencia='docencia'
			@investigacion= 'investigacion'
			@formacion= 'formacion'
			@extension= 'extension'
			@otra= 'otra' 

			@nombre = session[:nombre_usuario]
			@instructorName = session[:instructorName]

			actividades = AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: 0)
			if !actividades.blank?
				actividades.each do |actividadAde|
					actividad = Actividad.find(actividadAde.actividad_id)
					if actividad.tipo_actividad_id == 9
						@presentacion = actividad.actividad
					elsif actividad.tipo_actividad_id == 8
						@descripcion = actividad.actividad
					elsif actividad.tipo_actividad_id == 1
						@docencia = actividad.actividad	
					elsif actividad.tipo_actividad_id == 2
						@investigacion = actividad.actividad
					elsif actividad.tipo_actividad_id == 4
						@formacion = actividad.actividad	
					elsif actividad.tipo_actividad_id == 3
						@extension = actividad.actividad	
					end
				end
			else
				@presentacion = " "
				@descripcion = " "
				@docencia = " "	
				@investigacion = " "
				@formacion = " "	
				@extension = " "	
			end

			@actividades1doc= []
			@actividades1inv= []
			@actividades1ext= []
			@actividades1for= []
			@actividades1otr= []
			@actividades1= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: 1).all
			@actividades1.each do |actade| 
				@act= Actividad.find(actade.actividad_id)
				tipo= @act.tipo_actividad_id
				if tipo==1
					@actividades1doc.push(@act)
				else
					if tipo==2
						@actividades1inv.push(@act)
					else
						if tipo==3
							@actividades1ext.push(@act)
						else
							if tipo==4
								@actividades1for.push(@act)
							else
								if tipo==5
									@actividades1otr.push(@act)
								end
							end
						end
					end
				end
			end

			@actividades2doc= []
			@actividades2inv= []
			@actividades2ext= []
			@actividades2for= []
			@actividades2otr= []
			@actividades2= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: 2).all
			@actividades2.each do |actade| 
				@act= Actividad.find(actade.actividad_id)
				tipo= @act.tipo_actividad_id
				if tipo==1
					@actividades2doc.push(@act)
				else
					if tipo==2
						@actividades2inv.push(@act)
					else
						if tipo==3
							@actividades2ext.push(@act)
						else
							if tipo==4
								@actividades2for.push(@act)
							else
								if tipo==5
									@actividades2otr.push(@act)
								end
							end
						end
					end
				end
			end

			@actividades3doc= []
			@actividades3inv= []
			@actividades3ext= []
			@actividades3for= []
			@actividades3otr= []
			@actividades3= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: 3).all
			@actividades3.each do |actade| 
				@act= Actividad.find(actade.actividad_id)
				tipo= @act.tipo_actividad_id
				if tipo==1
					@actividades3doc.push(@act)
				else
					if tipo==2
						@actividades3inv.push(@act)
					else
						if tipo==3
							@actividades3ext.push(@act)
						else
							if tipo==4
								@actividades3for.push(@act)
							else
								if tipo==5
									@actividades3otr.push(@act)
								end
							end
						end
					end
				end
			end

			@actividades4doc= []
			@actividades4inv= []
			@actividades4ext= []
			@actividades4for= []
			@actividades4otr= []
			@actividades4= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: 4).all
			@actividades4.each do |actade| 
				@act= Actividad.find(actade.actividad_id)
				tipo= @act.tipo_actividad_id
				if tipo==1
					@actividades4doc.push(@act)
				else
					if tipo==2
						@actividades4inv.push(@act)
					else
						if tipo==3
							@actividades4ext.push(@act)
						else
							if tipo==4
								@actividades4for.push(@act)
							else
								if tipo==5
									@actividades4otr.push(@act)
								end
							end
						end
					end
				end
			end


			@actividades5doc= []
			@actividades5inv= []
			@actividades5ext= []
			@actividades5for= []
			@actividades5otr= []
			@actividades5= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: 5).all
			@actividades5.each do |actade| 
				@act= Actividad.find(actade.actividad_id)
				tipo= @act.tipo_actividad_id
<<<<<<< HEAD
				if tipo==1
					puts "soy una actividad de docencia"
					puts @act.actividad
					@actividades5doc.push(@act)
				else
					if tipo==2
						puts "soy una actividad de investigacion"
						puts @act.actividad
						@actividades5inv.push(@act)
					else
						if tipo==3
							puts "soy una actividad de extension"
							puts @act.actividad
							@actividades5ext.push(@act)
						else
							if tipo==4
								puts "soy una actividad de formacion"
								puts @act.actividad
								@actividades5for.push(@act)
							end
						end
					end
=======
				if tipo == 7
					@actividades5obli.push(@act)
>>>>>>> 687fd543c3dac836d8fdfb307fc713e9b2d54c55
				end
			end
		else 
			redirect_to controller:"forminst", action: "index"
		end

	end

	def cambiar_estatusA
		if session[:usuario_id] && session[:tutor]
	 		@adecuacion_id = params[:adecuacion_id].to_i
	 		@actividades1doc= []
			@actividades1inv= []
			@actividades1ext= []
			@actividades1for= []
			@actividades1otr= []
			g=0;
		    cambio_act = EstatusAdecuacion.where(adecuacion_id: @adecuacion_id, actual: 1).take

			if (cambio_act.estatus_id != 6 && cambio_act.estatus_id != 5)
		    	flash[:info]="Esta adecuación ya habia sido enviada"
		   	   	redirect_to controller:"iniciotutor", action: "planformacions"
		   	else
				@actividades1= AdecuacionActividad.where(adecuacion_id: @adecuacion_id, semestre: 1).all
				if @actividades1.blank?
			       	g = g + 1
				end
				a= false
				b= false
				c= false
				d= false
				e= false
				@actividades1.each do |actade| 
					@act= Actividad.find(actade.actividad_id)
					tipo= @act.tipo_actividad_id
					if tipo==1
						a = true
					else
						if tipo==2
							b = true
						else
							if tipo==3
								c = true
							else
								if tipo==4
									d = true
								else
									if tipo==5
										e = true
									end
								end
							end
						end
					end
				end
				if (a == true && b== true && c== true && d== true  && e== true)
				elsif ( a == true && b== true && c== true && d== true  && e== false)
					a = Actividad.new
					a.tipo_actividad_id = 5
					a.actividad = "Ninguna"
					a.save

					adac = AdecuacionActividad.new
					adac.adecuacion_id = @adecuacion_id
					adac.actividad_id = a.id
					adac.semestre = 1
					adac.save
				else 
					g = g + 1
				end

				@actividades2doc= []
				@actividades2inv= []
				@actividades2ext= []
				@actividades2for= []
				@actividades2otr= []
				@actividades2= AdecuacionActividad.where(adecuacion_id: @adecuacion_id, semestre: 2).all
				if @actividades2.blank?
					g = g + 1
				end
				a= false
				b= false
				c= false
				d= false
				e= false
				@actividades2.each do |actade| 
					@act= Actividad.find(actade.actividad_id)
					tipo= @act.tipo_actividad_id
					if tipo==1
						@actividades2doc.push(@act)
						a = true
					else
						if tipo==2
							@actividades2inv.push(@act)
							b = true
						else
							if tipo==3
								@actividades2ext.push(@act)
								c = true
							else
								if tipo==4
									@actividades2for.push(@act)
									d = true
								else
									if tipo==5
										@actividades2otr.push(@act)
										e = true
									end
								end
							end
						end
					end
				end
				if (a == true && b== true && c== true && d== true  && e== true)
				elsif ( a == true && b== true && c== true && d== true  && e== false)
					a = Actividad.new
					a.tipo_actividad_id = 5
					a.actividad = "Ninguna"
					a.save

					adac = AdecuacionActividad.new
					adac.adecuacion_id = @adecuacion_id
					adac.actividad_id = a.id
					adac.semestre = 2
					adac.save
				else 
					g = g + 1
				end
				@actividades3doc= []
				@actividades3inv= []
				@actividades3ext= []
				@actividades3for= []
				@actividades3otr= []
				@actividades3= AdecuacionActividad.where(adecuacion_id: @adecuacion_id, semestre: 3).all
				if @actividades3.blank?
			        g = g + 1
				end
				a= false
				b= false
				c= false
				d= false
				e= false
				@actividades3.each do |actade| 
					@act= Actividad.find(actade.actividad_id)
					tipo= @act.tipo_actividad_id
					if tipo==1
						@actividades3doc.push(@act)
						a = true
					else
						if tipo==2
							@actividades3inv.push(@act)
							b = true
						else
							if tipo==3
								@actividades3ext.push(@act)
								c = true
							else
								if tipo==4
									@actividades3for.push(@act)
									d = true
								else
									if tipo==5
										@actividades3otr.push(@act)
										e = true
									end
								end
							end
						end
					end
				end
				if (a == true && b== true && c== true && d== true  && e== true)
				elsif ( a == true && b== true && c== true && d== true  && e== false)
					a = Actividad.new
					a.tipo_actividad_id = 5
					a.actividad = "Ninguna"
					a.save

					adac = AdecuacionActividad.new
					adac.adecuacion_id = @adecuacion_id
					adac.actividad_id = a.id
					adac.semestre = 3
					adac.save
				else 
					g = g + 1
				end
				@actividades4doc= []
				@actividades4inv= []
				@actividades4ext= []
				@actividades4for= []
				@actividades4otr= []
				@actividades4= AdecuacionActividad.where(adecuacion_id: @adecuacion_id, semestre: 4).all
				if @actividades4.blank?
			        g = g + 1
				end
				a= false
				b= false
				c= false
				d= false
				e= false
				@actividades4.each do |actade| 
					@act= Actividad.find(actade.actividad_id)
					tipo= @act.tipo_actividad_id
					if tipo==1
						@actividades4doc.push(@act)
						a = true
					else
						if tipo==2
							@actividades4inv.push(@act)
							b = true
						else
							if tipo==3
								@actividades4ext.push(@act)
								c = true
							else
								if tipo==4
									@actividades4for.push(@act)
									d = true
								else
									if tipo==5
										@actividades4otr.push(@act)
										e = true
									end
								end
							end
						end
					end
				end
				if (a == true && b== true && c== true && d== true  && e== true)
				elsif ( a == true && b== true && c== true && d== true  && e== false)
					a = Actividad.new
					a.tipo_actividad_id = 5
					a.actividad = "Ninguna"
					a.save

					adac = AdecuacionActividad.new
					adac.adecuacion_id = @adecuacion_id
					adac.actividad_id = a.id
					adac.semestre = 4
					adac.save
				else 
						g = g + 1
				end
				aob = 0
				@actividades4= AdecuacionActividad.where(adecuacion_id: @adecuacion_id, semestre: 5).all
				if @actividades4.blank?
			        g = g + 1
			        aob = 1
				end

				are = 0
				@actividades4= AdecuacionActividad.where(adecuacion_id: @adecuacion_id, semestre: 0).all
				@actividades4.each do |cpActividadAdecuacion|
					cpActividad = Actividad.find(cpActividadAdecuacion.actividad_id)
					if cpActividad.tipo_actividad_id == 9 && !cpActividad.actividad.blank?
						are+=1
					end
					if cpActividad.tipo_actividad_id == 8 && !cpActividad.actividad.blank?
						are+=1
					end
					if cpActividad.tipo_actividad_id == 1 && !cpActividad.actividad.blank?
						are+=1
					end
					if cpActividad.tipo_actividad_id == 2 && !cpActividad.actividad.blank?
						are+=1
					end
					if cpActividad.tipo_actividad_id == 3 && !cpActividad.actividad.blank?
						are+=1
					end
					if cpActividad.tipo_actividad_id == 4 && !cpActividad.actividad.blank?
						are+=1
					end
				end

				if are != 6
					g=1
				end

				if (g != 0)
					if are == 6
						if aob == 0
							flash[:danger]="No puede enviar la adecuación sin haber llenado todos los semestres"
						else
							flash[:danger]="No puede enviar la adecuación sin tener al menos una actividad obligatoria"
						end
					else
						flash[:danger]="No puede enviar la adecuación sin estar terminada"
					end
			   	   	redirect_to controller:"iniciotutor", action: "detalles_adecuacion3"
			   	else
					plan = Planformacion.find(session[:plan_id])
			       	cambio_act.actual = 0
			      	cambio_act.save
			        cambio_est = EstatusAdecuacion.new 
			        cambio_est.adecuacion_id = @adecuacion_id
			        cambio_est.fecha = Time.now 
					notific = Notificacion.new
			        notific.instructor_id = plan.instructor_id
			        notific.tutor_id = session[:usuario_id]
			        notific.adecuacion_id = session[:adecuacion_id]
			        notific.informe_id = nil
			        notific.actual = 1
			        person = Persona.where(usuario_id: plan.instructor_id).take
			        notificacionfecha = Date.current.to_s
			        if (cambio_act.estatus_id == 6)
		        		notific.mensaje = "[" + notificacionfecha + "] La adecuación de "+ person.nombres.to_s.split.map(&:capitalize).join(' ') + " " + person.apellidos.to_s.split.map(&:capitalize).join(' ') + " se ha enviado a comisión de investigación."
			   		elsif (cambio_act.estatus_id == 5)
		        		notific.mensaje = "[" + notificacionfecha + "] La adecuación de "+ person.nombres.to_s.split.map(&:capitalize).join(' ') + " " + person.apellidos.to_s.split.map(&:capitalize).join(' ') + " se ha enviado a Consejo de Facultad para ser revisado nuevamente."
			        end
		        	notific.save
		        	notific2 = Notificacion.new
			        notific2.instructor_id = plan.instructor_id
			        notific2.tutor_id = session[:usuario_id]
			        notific2.adecuacion_id = session[:adecuacion_id]
			        notific2.informe_id = nil
			        notific2.actual = 2
			        if (cambio_act.estatus_id == 6)
			        	notific2.mensaje = "[" + notificacionfecha + "] Su adecuación se ha enviado a comisión de investigación."
			   		elsif (cambio_act.estatus_id == 5)
			        	notific2.mensaje = "[" + notificacionfecha + "] Su adecuación se ha enviado a Consejo de Facultad para ser revisado nuevamente"
			        end
		        	notific2.save
		        	notific3 = Notificacion.new
			        notific3.instructor_id = plan.instructor_id
			        notific3.tutor_id = session[:usuario_id]
			        notific3.adecuacion_id = session[:adecuacion_id]
			        notific3.informe_id = nil

					if (cambio_act.estatus_id == 6)
			       		notific3.actual = 3		#Comisión de investigación
			        	notific3.mensaje = "[" + notificacionfecha + "] Se ha recibido una nueva Adecuación: "+ person.nombres.to_s.split.map(&:capitalize).join(' ') + " " + person.apellidos.to_s.split.map(&:capitalize).join(' ') + ", favor revisar y enviar a la siguiente entidad."
			   		elsif (cambio_act.estatus_id == 5)
			        	notific3.actual = 5	 #Enviado a consejo de facultad
			        	notific3.mensaje = "[" + notificacionfecha + "] Se ha recibido una nueva Adecuación: "+ person.nombres.to_s.split.map(&:capitalize).join(' ') + " " + person.apellidos.to_s.split.map(&:capitalize).join(' ') + ", favor revisar."
			        end
		        	notific3.save
			        notific.save
    				respaldos = []
				    respaldos = Respaldo.where(adecuacion_id: @adecuacion_id, informe_id: nil).all
				   	numeroDeVersion = respaldos.size + 1
					nombre = generar_pdf()
					nameofthefile = "#{Rails.root}/tmp/PDFs/"+nombre
			   		#nameofthefile = nombre
					contents = IO.binread(nameofthefile)

			        respaldo = Respaldo.new 
			        respaldo.filename = nombre
			        respaldo.content_type = "application/pdf"
			        respaldo.file_contents = contents
			        respaldo.created_at = Date.current
			        respaldo.version = numeroDeVersion
			        respaldo.estatus = "Enviado a Comisión de Investigación"
			        respaldo.instructor_id = plan.instructor_id
			        respaldo.tutor_id = session[:usuario_id]
			        respaldo.adecuacion_id = session[:adecuacion_id]
			        respaldo.informe_id = nil
			        respaldo.actual = 1
			        if (cambio_act.estatus_id == 6)
			        	cambio_est.estatus_id = 3 #Enviado a comision de investigacion
			        	respaldo.estatus = "Enviado a Comisión de Investigación"
			   		elsif (cambio_act.estatus_id == 5)
			        	cambio_est.estatus_id = 4 #Enviado a consejo de facultad
			        	respaldo.estatus = "Enviado a Consejo de Facultad"
			        end
			        respaldo.save

			        cambio_est.actual = 1
			        cambio_est.save

			        if (cambio_act.estatus_id == 6)
			          	userr= Usuario.where(id: session[:usuario_id]).take
			         	 user =Usuarioentidad.where(usuario_id: userr.id).take
			         	if(user.escuela_id == 1)
			         		uentidad = Usuarioentidad.where(escuela_id: user.escuela_id, entidad_id: 7).take
			          	elsif(user.escuela_id == 2)
			              	uentidad = Usuarioentidad.where(escuela_id: user.escuela_id, entidad_id: 8).take
		            	elsif(user.escuela_id == 3)
		                	uentidad = Usuarioentidad.where(escuela_id: user.escuela_id, entidad_id: 9).take
		              	elsif(user.escuela_id == 4)
		                	uentidad = Usuarioentidad.where(escuela_id: user.escuela_id, entidad_id: 10).take
		                elsif(user.escuela_id == 9)
		                    uentidad = Usuarioentidad.where(escuela_id: user.escuela_id, entidad_id: 11).take
		                elsif(user.escuela_id == 10)
		                    uentidad = Usuarioentidad.where(escuela_id: user.escuela_id, entidad_id: 12).take
		                end

						remitente3 = Usuario.where(id: session[:usuario_id]).take
						ActionCorreo.envio_adecuacion(remitente3, notific.mensaje,2).deliver
						remitente2 = Usuario.where(id: plan.instructor_id).take
						ActionCorreo.envio_adecuacion(remitente2, notific2.mensaje,1).deliver
						remitente = Usuario.where(id: uentidad.usuario_id).take
						ActionCorreo.envio_adecuacion(remitente, notific3.mensaje,0).deliver
			        elsif (cambio_act.estatus_id == 5)
			        	uentidad = Usuarioentidad.where(entidad_id: 13).take
			        	remitente3 = Usuario.where(id: session[:usuario_id]).take
						ActionCorreo.envio_adecuacion(remitente3, notific.mensaje,2).deliver
						remitente2 = Usuario.where(id: plan.instructor_id).take
						ActionCorreo.envio_adecuacion(remitente2, notific2.mensaje,1).deliver
						remitente = Usuario.where(id: uentidad.usuario_id).take
						ActionCorreo.envio_adecuacion(remitente, notific3.mensaje,0).deliver
			        end

			        if(cambio_act.estatus_id == 5)
			        	flash[:success]="La adecuación se ha enviado a consejo de facultad"
			        else
			        	flash[:success]="La adecuación se ha enviado a comision de investigacion"
			        end


			   		redirect_to controller:"iniciotutor", action: "planformacions"
			   end
			end
		else 
			redirect_to controller:"forminst", action: "index"
		end
 	end 

  def generar_pdf() # es función permite generar el documento pdf de la adecuación
    @adecuacion= Adecuacion.find(session[:adecuacion_id]) # se obtienen la información de la adecuación seleccionada
    @planformacion= Planformacion.find(@adecuacion.planformacion_id)
    @fechaConcurso = @planformacion.fecha_inicio
    @id_docente= @planformacion.tutor_id # se obtiene el indicador del ususario al que corresponde la adecuación
    @usertutor= Usuario.find(@id_docente) # se obtiene la información del tutor mediante la base de datos y la variable anterior
    @tutor= Persona.where(usuario_id: @id_docente).take
    @id_instructor= @planformacion.instructor_id # se toma el identificador del instructor
    @userinst=Usuario.find(@id_instructor) # se obtienen toda la información del instructor 
    @instructor= Persona.where(usuario_id: @id_instructor).take
    @fechaActual = Date.current.to_s
    @userentidad= Usuarioentidad.where(usuario_id: @planformacion.instructor_id).take
      if @userentidad.escuela_id == nil
        @userentidad.escuela_id=12
        @userentidad.save
        @escuela= Escuela.where(id: @userentidad.escuela_id).take
      else
        @escuela= Escuela.where(id: @userentidad.escuela_id).take
      end

    @userinst2=Usuario.find(@id_docente) # se obtienen toda la información del tutor
    @correot= @userinst2.user+'@ciens.ucv.ve'
    @correoi=  @userinst.user+'@ciens.ucv.ve'
    
    @pactv_docencia= []
    @pactv_investigacion= []
    @pactv_formacion= []
    @pactv_extension=[]
    @pactv_otras=[]
    @sactv_docencia= []
    @sactv_investigacion= []
    @sactv_formacion= []
    @sactv_extension=[]
    @sactv_otras=[]
    @tactv_docencia= []
    @tactv_investigacion= []
    @tactv_formacion= []
    @tactv_extension=[]
    @tactv_otras=[]
    @cactv_docencia= []
    @cactv_investigacion= []
    @cactv_formacion= []
    @cactv_extension=[]
    @cactv_otras=[]
    @dactv_docencia= []
    @dactv_investigacion= []
    @dactv_formacion= []
    @dactv_extension=[]

    @actividadesa= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: 1).all
    @actividadesa.each do |actade| 
      @act= Actividad.find(actade.actividad_id)
      tipo= @act.tipo_actividad_id
      if tipo==1
        @pactv_docencia.push(@act)
      else
        if tipo==2
          @pactv_investigacion.push(@act)
        else
          if tipo==3
            @pactv_extension.push(@act)
          else
            if tipo==4
              @pactv_formacion.push(@act)
            else
              if tipo==5
                @pactv_otras.push(@act)
              end
            end
          end
        end
      end
    end

    @sactividadesa= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: 2).all
    @sactividadesa.each do |actade| 
      @act= Actividad.find(actade.actividad_id)
      tipo= @act.tipo_actividad_id
      if tipo==1
        @sactv_docencia.push(@act)
      else
        if tipo==2
          @sactv_investigacion.push(@act)
        else
          if tipo==3
            @sactv_extension.push(@act)
          else
            if tipo==4
              @sactv_formacion.push(@act)
            else
              if tipo==5
                @sactv_otras.push(@act)
              end
            end
          end
        end
      end
    end

    @tactividadesa= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: 3).all
    @tactividadesa.each do |actade| 
      @act= Actividad.find(actade.actividad_id)
      tipo= @act.tipo_actividad_id
      if tipo==1
        @tactv_docencia.push(@act)
      else
        if tipo==2
          @tactv_investigacion.push(@act)
        else
          if tipo==3
            @tactv_extension.push(@act)
          else
            if tipo==4
              @tactv_formacion.push(@act)
            else
              if tipo==5
                @tactv_otras.push(@act)
              end
            end
          end
        end
      end
    end

    @cactividadesa= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: 4).all
    @cactividadesa.each do |actade| 
      @act= Actividad.find(actade.actividad_id)
      tipo= @act.tipo_actividad_id
      if tipo==1
        @cactv_docencia.push(@act)
      else
        if tipo==2
          @cactv_investigacion.push(@act)
        else
          if tipo==3
            @cactv_extension.push(@act)
          else
            if tipo==4
              @cactv_formacion.push(@act)
            else
              if tipo==5
                @cactv_otras.push(@act)
              end
            end
          end
        end
      end
    end

    @cactividadesa= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: 5).all
    @cactividadesa.each do |actade| 
      @act= Actividad.find(actade.actividad_id)
      tipo= @act.tipo_actividad_id
<<<<<<< HEAD
      if tipo==1
        puts "soy una actividad de docencia"
        puts @act.actividad
        @dactv_docencia.push(@act)
      else
        if tipo==2
          puts "soy una actividad de investigacion"
          puts @act.actividad
          @dactv_investigacion.push(@act)
        else
          if tipo==3
            puts "soy una actividad de extension"
            puts @act.actividad
            @dactv_extension.push(@act)
          else
            if tipo==4
              puts "soy una actividad de formacion"
              puts @act.actividad
              @dactv_formacion.push(@act)
            end
          end
        end
=======
      if tipo==7
        @dactv_obligatorias.push(@act)
>>>>>>> 687fd543c3dac836d8fdfb307fc713e9b2d54c55
      end
    end
    @documents = []
    @documents = Document.where(adecuacion_id: @adecuacion.id, informe_id: nil).all
    # se llama a la función de "pedf_adecuacion" del modelo "pdf", pasando todas las variables correspondientes
    respaldos = []
    respaldos = Respaldo.where(adecuacion_id: @adecuacion.id, informe_id: nil).all
    @numeroDeVersion = respaldos.size + 1
    @actividades1 = []
    actividades = AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: 0)
	if !actividades.blank?
      	actividades.each do |actividadAde|
	        actividad = Actividad.find(actividadAde.actividad_id)
	        @actividades1.push(actividad)
      	end
    end
    Pdf.pdf_adecuacion(@actividades1, @planformacion, @adecuacion, @tutor, @instructor, @correoi, @correot, @escuela, @pactv_docencia, @pactv_investigacion, @pactv_extension, @pactv_formacion, @pactv_otras, @sactv_docencia, @sactv_investigacion, @sactv_extension, @sactv_formacion, @sactv_otras, @tactv_docencia, @tactv_investigacion, @tactv_extension, @tactv_formacion, @tactv_otras, @cactv_docencia, @cactv_investigacion, @cactv_extension, @cactv_formacion, @cactv_otras, @fechaActual, @fechaConcurso, @documents, @numeroDeVersion, @dactv_docencia, @dactv_investigacion, @dactv_extension, @dactv_formacion)
    @nombre_archivo= @instructor.ci.to_s+'-'+@fechaActual+'-adecuacionV'+@numeroDeVersion.to_s+'.pdf' # se arma el nombre del documento 
    act = "#{Rails.root}/tmp/PDFs" + @nombre_archivo
    return @nombre_archivo # se retorna el nombre del archivo
  end

	def mas_observaciones3 #mas obs de actividades del informe

		@adecuacion= Adecuacion.find(session[:adecuacion_id])
		@planformacion=Planformacion.find(@adecuacion.planformacion_id)
		if !@planformacion.blank?
			#Ver si el informe fue rachazado
			cpInstructor = Usuario.find(@planformacion.instructor_id)
			if (cpInstructor.activo == false)
				@cpBloquear = true
			else
				@cpBloquear = false
			end
			#fin
		end

		@semestre = params[:semestre].to_i
 		@actividad_id = params[:actividad_id].to_i
		
		aa= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: @semestre, actividad_id: @actividad_id).take
		
		@observaciones = ObservacionActividadAdecuacion.where(adecuacionactividad_id: aa.id)

		@observaciones.each do |obs|	
			if(obs.observaciones != "")
			@boolobs = 1
			end
		end
			

		@observaciones.each do |obs|

			rev = Revision.find(obs.revision_id)
		
			entidad = Usuarioentidad.where(usuario_id: rev.usuario_id).take

			
			if (entidad.entidad_id  >= 7 && entidad.entidad_id  <= 12)
			#comision investigacion		
					@obs_inv = obs.observaciones  #Estatus enviado a comision de investigacion
					
			else
				if (entidad.entidad_id  >= 14 && entidad.entidad_id  <= 17)
				#Consejo tecnico
					@obs_consejoT = obs.observaciones
				else
					if (entidad.entidad_id  >= 1 && entidad.entidad_id  <= 6)
					#Consejo de escuela
						@obs_consejoE = obs.observaciones
					else
						if (entidad.entidad_id  == 13)
						#Consejo de facultad
							@obs_consejoF =  obs.observaciones

						end	
					end
				end
			end
		end
			
	end

	def ver_respaldos
		if session[:usuario_id] && session[:tutor] 
		  @plan = Planformacion.where(id: session[:plan_id]).take
		  if !@plan.blank?
			#Ver si el informe fue rachazado
			cpInstructor = Usuario.find(@plan.instructor_id)
			if (cpInstructor.activo == false)
				@cpBloquear = true
			else
				@cpBloquear = false
			end
			#fin
		  end
		  @documents = []
		  if !session[:informe_id].blank?
		    @documents = Respaldo.where(adecuacion_id: session[:adecuacion_id], informe_id: session[:informe_id]).all
		  else
		    @documents = Respaldo.where(adecuacion_id: session[:adecuacion_id], informe_id: nil).all
		  end
		else
		  redirect_to controller:"forminst", action: "index"
		end
	end

	def show

		if params[:informe_id].blank?
			@document = Respaldo.where(adecuacion_id: params[:adecuacion_id], informe_id: nil, version: params[:version].to_i, filename: params[:namefile]).take
		else
			@document = Respaldo.where(adecuacion_id: params[:adecuacion_id], informe_id: params[:informe_id],version: params[:version].to_i, filename: params[:namefile]).take
		end
	    send_data(@document.file_contents,
	              type: @document.content_type,
	              filename: @document.filename)
  	end

	def borrar_notificaciones #mas obs de actividades del informe
		if session[:usuario_id] && session[:tutor]
			@noti= params[:noti]
    		notaeliminar = Notificacion.where(id: @noti ).take
    		if notaeliminar.blank?
    			flash[:danger] = "Ha ocurrido un error al eliminar (notificacion no existente)"
    		else
    			notaeliminar.destroy
    		end
			redirect_to controller:"iniciotutor", action: "notificaciones"
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def borrar_notificaciones1 #mas obs de actividades del informe
		if session[:usuario_id] && session[:tutor]
			@noti= params[:noti]
    		notaeliminar = Notificacion.where(id: @noti ).take
    		if notaeliminar.blank?
    			flash[:danger] = "Ha ocurrido un error al eliminar (notificacion no existente)"
    		else
    			notaeliminar.destroy
    		end
			redirect_to controller:"iniciotutor", action: "index"
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def notificaciones #mas obs de actividades del informe
		if session[:usuario_id] && session[:tutor]
    		@planformacions = Planformacion.where(tutor_id: session[:usuario_id])
    		@notificaciones1= []
			@notificaciones = Notificacion.where( tutor_id: session[:usuario_id]).all
			@notificaciones.each do |notificaciones|
				if notificaciones.actual == 1					#Caso de notificaciones del tutor
					@notificaciones1.push(notificaciones)
				end
			end
		else
			redirect_to controller:"forminst", action: "index"
		end
	end
end
