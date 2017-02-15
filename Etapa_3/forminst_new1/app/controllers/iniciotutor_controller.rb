class IniciotutorController < ApplicationController
	layout 'ly_inicio_tutor'

	def index
		@logout = params[:logout]
		if session[:usuario_id]
			session[:adecuacion_id] = nil
			session[:plan_id] = nil
			session[:instructorName] = nil

			@nombre = session[:nombre_usuario]
			if not @nombre
				print "NO HAY USUARIO"
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
		puts "entre a plan formacion"
		if session[:usuario_id]
			session[:adecuacion_id] = nil
			@persona = Persona.where(usuario_id: session[:usuario_id]).take
    		@planformacions = Planformacion.where(tutor_id: session[:usuario_id])
    		@nombreinstructor= []
			@planformacions.each do |plan|
				puts "entre al for each"
				@person= Persona.where(usuario_id: plan.instructor_id).take
				puts "deberia colocar en el arreglo el nombre"
				puts @person.nombres
				@nombreinstructor.push(@person.nombres)
			end
			puts "soy el tamano del arreglo de nombre"
			puts @nombreinstructor.size()
			@nombre = session[:nombre_usuario]
			if not @nombre
				print "NO HAY USUARIO"
			end
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def ver_detalles_plan
		if session[:usuario_id]
			session[:adecuacion_id] = nil
			@persona = Persona.where(usuario_id: session[:usuario_id]).take
			@nombre = session[:nombre_usuario]
			if params[:plan_id]
				puts "HAY SESION PLAN"
				@planformacion = Planformacion.find(params[:plan_id])
				session[:plan_id] = @planformacion.id
			else
				puts "NO HAY SESION PLAN"
				@planformacion = Planformacion.find(session[:plan_id])
				session[:plan_id] = @planformacion.id
			end
			@instructorName = Persona.where(usuario_id: @planformacion.instructor_id).take.nombres
			session[:instructorName] = @instructorName


			@fechaInicio = @planformacion.fecha_inicio
			@fechaFin = @planformacion.fecha_fin

			if not @nombre
				print "NO HAY USUARIO"
			end
		else
			redirect_to controller:"forminst", action: "index"
		end
	end 

	def listar_adecuaciones
		if session[:usuario_id]
			session[:adecuacion_id] = nil
			@persona = Persona.where(usuario_id: session[:usuario_id]).take
			@nombre = session[:nombre_usuario]
			@plan = Planformacion.find(session[:plan_id])
			@name = session[:instructorName]
			@status= []

			#@adecuaciones = Adecuacion.find(:all, :conditions => ["planformacion_id = ?",@planformacion], :order=> "id DESC") #(DESPUES VEMOS COMO ES ESTO DEL PAGINATE).paginate(:page => params[:page], :per_page => 10) # se buscan todas las adecuaciones correspondientes al usuario y se paginan de 10 en 10 
			@adecuaciones = Adecuacion.where(planformacion_id: session[:plan_id])
			@adecuacion = Adecuacion.where(planformacion_id: session[:plan_id]).take
			
			@adecuaciones.each do |adecuacion| 
				@est= EstatusAdecuacion.where(adecuacion_id: adecuacion.id, actual: 1).take
				if @est.estatus_id == 1
					@status.push("APROBADO POR CONSEJO DE FACULTAD")
				else 
					if @est.estatus_id == 2
						@status.push("ENVIADO A CONSEJO TECNICO")
					else
						if @est.estatus_id == 3
							@status.push("ENVIADO A COMISIÓN DE INVESTIGACIÓN")
						else
							if @est.estatus_id == 4
								@status.push("ENVIADO A CONSEJO DE FACULTAD")
							else
								if @est.estatus_id == 5
									@status.push("APROBADO CON OBSERVACIONES POR CONSEJO DE FACULTAD")
								else
									if @est.estatus_id == 6
										@status.push("GUARDADO")
									else
										if @est.estatus_id == 7
											@status.push("EN REVISIÓN MENOR POR COMISIÓN DE INVESTIGACIÓN")
										else
											if @est.estatus_id == 8
												@status.push("ENVIADO A CONSEJO DE ESCUELA")
											else
												if @est.estatus_id == 9
													@status.push("RECHAZADO POR CONSEJO DE FACULTAD")
												end
											end
										end
									end
								end
							end
						end
					end
				end								
			end
			#find(:all, :conditions => ["planformacion_id = ?", @planformacion]) #(DESPUES VEMOS COMO ES ESTO DEL PAGINATE).paginate(:page => params[:page], :per_page => 10) # se buscan todas las adecuaciones correspondientes al usuario y se paginan de 10 en 10 
			# esto de arriba no se como funciona pero estaba en el forminst de antes							
			if not @nombre
				print "NO HAY USUARIO"
			end
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def prorroga
		if session[:usuario_id]
			session[:adecuacion_id] = nil
			puts "UNO"
			@persona = Persona.where(usuario_id: session[:usuario_id]).take
			puts "DOS"
			@nombre = session[:nombre_usuario]
			puts "TRES"
			puts session[:plan_id]
			@planformacion = session[:plan_id]
			if not @planformacion
				puts "NO HAY Planformacion"
			end
			@instructorName = session[:instructorName]
			if not @instructorName
				puts "NO HAY instructorName"
			end
			
			puts "********-**************"
			puts @planformacion
			puts @instructorName
			puts "*********-**************"

			if not @nombre
				print "NO HAY USUARIO"
			end
		else
			redirect_to controller:"forminst", action: "index"
		end
	end
	

	def crear_adecuacion
		if session[:usuario_id]
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
				redirect_to controller:"iniciotutor", action: "listar_adecuaciones"
			end
		else
			redirect_to controller:"forminst", action: "index"
		end
	end
	def crear_adecuacion_semestre2
		if session[:usuario_id]
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
		if session[:usuario_id]
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
		if session[:usuario_id]
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
		if session[:usuario_id]
			@nombre = session[:nombre_usuario]
			@instructorName = session[:instructorName]
			@modifique=false
			@cant_delete= params[:cant_delete]
			@cant_edit= params[:cant_edit]
			@cant_doc= params[:cant_docencia]
			@cant_inv= params[:cant_investigacion]
			@cant_for= params[:cant_formacion]
			@cant_ext= params[:cant_extension]
			@cant_otr= params[:cant_otra]
			semestre= params[:semestre].to_i

			if params[:adecuacion_id]!=nil
				session[:adecuacion_id]= params[:adecuacion_id]
			end
			@adecuacion= Adecuacion.find(session[:adecuacion_id])
			@plan= Planformacion.find(session[:plan_id])
			@userentidad= Usuarioentidad.where(usuario_id: @plan.instructor_id).take
			if @userentidad.escuela_id == nil
				@userentidad.escuela_id=12
				@userentidad.save
				@escuela= Escuela.where(id: @userentidad.escuela_id).take
			else
				@escuela= Escuela.where(id: @userentidad.escuela_id).take
			end
			puts "id del instructor"
			puts @plan.instructor_id
			@instructor= Persona.where(usuario_id: @plan.instructor_id).take

			@actividadesadoc= []
			@actividadesainv= []
			@actividadesaext= []
			@actividadesafor= []
			@actividadesaotr= []

			puts "------"
			puts @cant_edit.to_i
			puts "------"


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
									end
								end
							end
						end
					end
					@act.actividad= text
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
					puts @adecuacion.id
					puts a.id
					puts semestre
					adac = AdecuacionActividad.new
					adac.adecuacion_id = @adecuacion.id
					adac.actividad_id = a.id
					adac.semestre = semestre
					adac.save
				end
				j = j + 1
				i=:nuevadoc.to_s+j.to_s;
				@docencias = params[i]
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
					puts @adecuacion.id
					puts a.id
					puts semestre
					adac = AdecuacionActividad.new
					adac.adecuacion_id = @adecuacion.id
					adac.actividad_id = a.id
					adac.semestre = semestre
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
					puts @adecuacion.id
					puts a.id
					puts semestre
					adac = AdecuacionActividad.new
					adac.adecuacion_id = @adecuacion.id
					adac.actividad_id = a.id
					adac.semestre = semestre
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
					puts @adecuacion.id
					puts a.id
					puts semestre
					adac = AdecuacionActividad.new
					adac.adecuacion_id = @adecuacion.id
					adac.actividad_id = a.id
					adac.semestre = semestre
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
					puts @adecuacion.id
					puts a.id
					puts semestre
					adac = AdecuacionActividad.new
					adac.adecuacion_id = @adecuacion.id
					adac.actividad_id = a.id
					adac.semestre = semestre
					adac.save
				end
				j = j + 1
				i=:nuevaotr.to_s+j.to_s;
				@otra = params[i]
			end

			if @modifique == true
				flash[:mensaje]= "La adecuación fue modificada y guardada correctamente"
				redirect_to controller:"iniciotutor", action: "detalles_adecuacion3"
			end
			
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def detalles_adecuacion2
		if session[:usuario_id]
			@nombre = session[:nombre_usuario]
			@instructorName = session[:instructorName]
			@adecuacion= Adecuacion.find(session[:adecuacion_id])
			@plan= Planformacion.find(session[:plan_id])
			@userentidad= Usuarioentidad.where(usuario_id: @plan.instructor_id).take
			@escuela= Escuela.find(@userentidad.escuela_id)
			@persona= Persona.where(usuario_id: @plan.instructor_id).take
			@usuario= Usuario.find(@plan.instructor_id)
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def detalles_adecuacion3

		if session[:usuario_id]
			@iddoc= 'id_docencia'
			@docencia='docencia'
			@investigacion= 'investigacion'
			@formacion= 'formacion'
			@extension= 'extension'
			@otra= 'otra' 
			@nombre = session[:nombre_usuario]
			@instructorName = session[:instructorName]
			@adecuacion= Adecuacion.find(session[:adecuacion_id])
			@plan= Planformacion.find(session[:plan_id])
			@actividadesadoc= []
			@actividadesainv= []
			@actividadesaext= []
			@actividadesafor= []
			@actividadesaotr= []
			@actividadesa= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: 1).all
			@actividadesa.each do |actade| 
				@act= Actividad.find(actade.actividad_id)
				tipo= @act.tipo_actividad_id
				if tipo==1
					puts "soy una actividad de docencia"
					puts @act.actividad
					@actividadesadoc.push(@act)
				else
					if tipo==2
						puts "soy una actividad de investigacion"
						puts @act.actividad
						@actividadesainv.push(@act)
					else
						if tipo==3
							puts "soy una actividad de extension"
							puts @act.actividad
							@actividadesaext.push(@act)
						else
							if tipo==4
								puts "soy una actividad de formacion"
								puts @act.actividad
								@actividadesafor.push(@act)
							else
								if tipo==5
									puts "soy otro tipo de actividad"
									puts @act.actividad
									@actividadesaotr.push(@act)
								end
							end
						end
					end
				end
			end
			@bool_enviado = 0
			estatus_adecuacion = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take

			if (estatus_adecuacion.estatus_id != 6 && estatus_adecuacion.estatus_id != 5)
				@bool_enviado = 1
			end
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def detalles_adecuacion4
		if session[:usuario_id]
			@iddoc= 'id_docencia'
			@docencia='docencia'
			@investigacion= 'investigacion'
			@formacion= 'formacion'
			@extension= 'extension'
			@otra= 'otra' 
			@nombre = session[:nombre_usuario]
			@instructorName = session[:instructorName]
			@adecuacion= Adecuacion.find(session[:adecuacion_id])
			@plan= Planformacion.find(session[:plan_id])
			@actividadesadoc= []
			@actividadesainv= []
			@actividadesaext= []
			@actividadesafor= []
			@actividadesaotr= []
			@actividadesa= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: 2).all
			@actividadesa.each do |actade| 
				@act= Actividad.find(actade.actividad_id)
				tipo= @act.tipo_actividad_id
				if tipo==1
					puts "soy una actividad de docencia"
					puts @act.actividad
					@actividadesadoc.push(@act)
				else
					if tipo==2
						puts "soy una actividad de investigacion"
						puts @act.actividad
						@actividadesainv.push(@act)
					else
						if tipo==3
							puts "soy una actividad de extension"
							puts @act.actividad
							@actividadesaext.push(@act)
						else
							if tipo==4
								puts "soy una actividad de formacion"
								puts @act.actividad
								@actividadesafor.push(@act)
							else
								if tipo==5
									puts "soy otro tipo de actividad"
									puts @act.actividad
									@actividadesaotr.push(@act)
								end
							end
						end
					end
				end
			end
			@bool_enviado = 0
			estatus_adecuacion = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take

			if (estatus_adecuacion.estatus_id != 6 && estatus_adecuacion.estatus_id != 5)
				@bool_enviado = 1
			end

		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def detalles_adecuacion5
		if session[:usuario_id]
			@iddoc= 'id_docencia'
			@docencia='docencia'
			@investigacion= 'investigacion'
			@formacion= 'formacion'
			@extension= 'extension'
			@otra= 'otra' 
			@nombre = session[:nombre_usuario]
			@instructorName = session[:instructorName]
			@adecuacion= Adecuacion.find(session[:adecuacion_id])
			@plan= Planformacion.find(session[:plan_id])
			@actividadesadoc= []
			@actividadesainv= []
			@actividadesaext= []
			@actividadesafor= []
			@actividadesaotr= []
			@actividadesa= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: 3).all
			@actividadesa.each do |actade| 
				@act= Actividad.find(actade.actividad_id)
				tipo= @act.tipo_actividad_id
				if tipo==1
					puts "soy una actividad de docencia"
					puts @act.actividad
					@actividadesadoc.push(@act)
				else
					if tipo==2
						puts "soy una actividad de investigacion"
						puts @act.actividad
						@actividadesainv.push(@act)
					else
						if tipo==3
							puts "soy una actividad de extension"
							puts @act.actividad
							@actividadesaext.push(@act)
						else
							if tipo==4
								puts "soy una actividad de formacion"
								puts @act.actividad
								@actividadesafor.push(@act)
							else
								if tipo==5
									puts "soy otro tipo de actividad"
									puts @act.actividad
									@actividadesaotr.push(@act)
								end
							end
						end
					end
				end
			end
			@bool_enviado = 0
			estatus_adecuacion = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take

			if (estatus_adecuacion.estatus_id != 6 && estatus_adecuacion.estatus_id != 5)
				@bool_enviado = 1
			end
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def detalles_adecuacion6
		if session[:usuario_id]
			@iddoc= 'id_docencia'
			@docencia='docencia'
			@investigacion= 'investigacion'
			@formacion= 'formacion'
			@extension= 'extension'
			@otra= 'otra' 
			@nombre = session[:nombre_usuario]
			@instructorName = session[:instructorName]
			@adecuacion= Adecuacion.find(session[:adecuacion_id])
			@plan= Planformacion.find(session[:plan_id])
			@actividadesadoc= []
			@actividadesainv= []
			@actividadesaext= []
			@actividadesafor= []
			@actividadesaotr= []
			@actividadesa= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: 4).all
			@actividadesa.each do |actade| 
				@act= Actividad.find(actade.actividad_id)
				tipo= @act.tipo_actividad_id
				if tipo==1
					puts "soy una actividad de docencia"
					puts @act.actividad
					@actividadesadoc.push(@act)
				else
					if tipo==2
						puts "soy una actividad de investigacion"
						puts @act.actividad
						@actividadesainv.push(@act)
					else
						if tipo==3
							puts "soy una actividad de extension"
							puts @act.actividad
							@actividadesaext.push(@act)
						else
							if tipo==4
								puts "soy una actividad de formacion"
								puts @act.actividad
								@actividadesafor.push(@act)
							else
								if tipo==5
									puts "soy otro tipo de actividad"
									puts @act.actividad
									@actividadesaotr.push(@act)
								end
							end
						end
					end
				end
			end
			@bool_enviado = 0
			estatus_adecuacion = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take

			if (estatus_adecuacion.estatus_id != 6 && estatus_adecuacion.estatus_id != 5)
				@bool_enviado = 1
			end
		else
			redirect_to controller:"forminst", action: "index"
		end
	end


	def guardar_adecuacion
		if session[:usuario_id]

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

			if @ade == nil

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
					puts @docencias

					if  @docencias!=nil && @docencias!=""
						if @docencias!=nil && @docencias!=""
							puts "------------"
						end
						puts "entre al if"
						puts @docencias

						a = Actividad.new
						a.tipo_actividad_id = 1
						a.actividad = @docencias
						a.save
						puts "guarde la actividad de docencia: " + @docencias

						adac = AdecuacionActividad.new
						adac.adecuacion_id = ad.id
						adac.actividad_id = a.id
						adac.semestre = semestre
						adac.save
						puts "guarde la adecuacion actividad: "
					end
					j = j + 1
					i=:docencia.to_s+j.to_s;
					@docencias = params[i]
				end

				j= 0
				i=:investigacion.to_s+j.to_s;
				investigacion = params[i]
				while j < cant_investigacion.to_i
					puts investigacion
					if  investigacion!=nil && investigacion!=""
							
						a = Actividad.new
						a.tipo_actividad_id = 2
						a.actividad = investigacion
						a.save

						puts "guarde la actividad de investigacion: "+investigacion

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
					puts extension
					if  extension!=nil && extension!=""

						a = Actividad.new
						a.tipo_actividad_id = 3
						a.actividad = extension
						a.save

						puts "guarde la actividad de extension: "+extension
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
					puts formacion
					if  formacion!=nil && formacion!=""
						
						a = Actividad.new
						a.tipo_actividad_id = 4
						a.actividad = formacion
						a.save

						puts "guarde la actividad de formacion: "+formacion
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
					puts otra
					if  otra!=nil && otra!=""
						
						a = Actividad.new
						a.tipo_actividad_id = 5
						a.actividad = otra
						a.save

						puts "guarde la actividad de otra: "+otra
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
				flash[:mensaje]= "La adecuación fue creada y guardada correctamente"
				redirect_to controller:"iniciotutor", action: "listar_adecuaciones"
			else
				flash[:mensaje]= "La adecuación no fue creada porque ya posee una asociada para este plan de formación"
				redirect_to controller:"iniciotutor", action: "listar_adecuaciones"
			end

		else
			redirect_to controller:"forminst", action: "index"
		end
		
	end

	def eliminar_adecuacion
		@adecuacion= Adecuacion.find(session[:adecuacion_id])
		@est= EstatusAdecuacion.where(adecuacion_id: @adecuacion.id).take
		if @est.estatus_id == 6
			@adecuacion.destroy
			flash[:mensaje]= "La adecuacion fue eliminada correctamente"
		else
			flash[:mensaje]= "No está permitido eliminar esta adecuación"
		end
		redirect_to controller:"iniciotutor", action: "listar_adecuaciones"
	end

	def vista_previa
		@plan= Planformacion.find(session[:plan_id])
		@usere= Usuarioentidad.where(usuario_id: @plan.instructor_id).take
		@escuela= Escuela.find(@usere.escuela_id)
		@adecuacion= Adecuacion.where(planformacion_id: @plan.id).take
		@adscripcion_docencia= @plan.adscripcion_docencia
		@adscripcion_investigacion= @plan.adscripcion_investigacion
		@persona= Persona.where(usuario_id: @plan.instructor_id).take
		@user = Usuario.find(@plan.instructor_id)

		@docencia='docencia'
		@investigacion= 'investigacion'
		@formacion= 'formacion'
		@extension= 'extension'
		@otra= 'otra' 

		@nombre = session[:nombre_usuario]
		@instructorName = session[:instructorName]

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
				puts "soy una actividad de docencia"
				puts @act.actividad
				@actividades1doc.push(@act)
			else
				if tipo==2
					puts "soy una actividad de investigacion"
					puts @act.actividad
					@actividades1inv.push(@act)
				else
					if tipo==3
						puts "soy una actividad de extension"
						puts @act.actividad
						@actividades1ext.push(@act)
					else
						if tipo==4
							puts "soy una actividad de formacion"
							puts @act.actividad
							@actividades1for.push(@act)
						else
							if tipo==5
								puts "soy otro tipo de actividad"
								puts @act.actividad
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
				puts "soy una actividad de docencia"
				puts @act.actividad
				@actividades2doc.push(@act)
			else
				if tipo==2
					puts "soy una actividad de investigacion"
					puts @act.actividad
					@actividades2inv.push(@act)
				else
					if tipo==3
						puts "soy una actividad de extension"
						puts @act.actividad
						@actividades2ext.push(@act)
					else
						if tipo==4
							puts "soy una actividad de formacion"
							puts @act.actividad
							@actividades2for.push(@act)
						else
							if tipo==5
								puts "soy otro tipo de actividad"
								puts @act.actividad
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
				puts "soy una actividad de docencia"
				puts @act.actividad
				@actividades3doc.push(@act)
			else
				if tipo==2
					puts "soy una actividad de investigacion"
					puts @act.actividad
					@actividades3inv.push(@act)
				else
					if tipo==3
						puts "soy una actividad de extension"
						puts @act.actividad
						@actividades3ext.push(@act)
					else
						if tipo==4
							puts "soy una actividad de formacion"
							puts @act.actividad
							@actividades3for.push(@act)
						else
							if tipo==5
								puts "soy otro tipo de actividad"
								puts @act.actividad
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
				puts "soy una actividad de docencia"
				puts @act.actividad
				@actividades4doc.push(@act)
			else
				if tipo==2
					puts "soy una actividad de investigacion"
					puts @act.actividad
					@actividades4inv.push(@act)
				else
					if tipo==3
						puts "soy una actividad de extension"
						puts @act.actividad
						@actividades4ext.push(@act)
					else
						if tipo==4
							puts "soy una actividad de formacion"
							puts @act.actividad
							@actividades4for.push(@act)
						else
							if tipo==5
								puts "soy otro tipo de actividad"
								puts @act.actividad
								@actividades4otr.push(@act)
							end
						end
					end
				end
			end
		end

	end

	def cambiar_estatusA

 		@adecuacion_id = params[:adecuacion_id].to_i
	      	
	      	cambio_act = EstatusAdecuacion.where(adecuacion_id: @adecuacion_id, actual: 1).take
	      	cambio_act.actual = 0
	      	cambio_act.save

	        cambio_est = EstatusAdecuacion.new 
	        cambio_est.adecuacion_id = @adecuacion_id
	        cambio_est.fecha = Time.now 

	        if(cambio_act.estatus_id == 5)
	        	cambio_est.estatus_id = 4
	        else
	        	cambio_est.estatus_id = 3
	        end
	        cambio_est.actual = 1
	        cambio_est.save

	         if cambio_act.estatus_id == 6

	          userr= Usuario.where(id: session[:usuario_id]).take
	          user =Usuarioentidad.where(usuario_id: userr.id).take
	          if(user.escuela_id == 1)
	            uentidad = Usuarioentidad.where(escuela_id: user.escuela_id, entidad_id: 7).take
	          else
	            if(user.escuela_id == 2)
	              uentidad = Usuarioentidad.where(escuela_id: user.escuela_id, entidad_id: 8).take
	            else
	              if(user.escuela_id == 3)
	                uentidad = Usuarioentidad.where(escuela_id: user.escuela_id, entidad_id: 9).take
	              else
	                if(user.escuela_id == 4)
	                uentidad = Usuarioentidad.where(escuela_id: user.escuela_id, entidad_id: 10).take
	                else
	                  if(user.escuela_id == 9)
	                    uentidad = Usuarioentidad.where(escuela_id: user.escuela_id, entidad_id: 11).take
	                  else
	                    if(user.escuela_id == 10)
	                      uentidad = Usuarioentidad.where(escuela_id: user.escuela_id, entidad_id: 12).take
	                    end
	                  end
	                end
	              end
	            end  
	          end
	          remitente = Usuario.where(id: uentidad.usuario_id).take
	          email = remitente.user + "@ciens.ucv.ve"
	          ActionCorreo.envio_adecuacion(email).deliver

	        else
	            uentidad = Usuarioentidad.where(entidad_id: 13).take
	            remitente = Usuario.where(id: uentidad.usuario_id).take
	            email= remitente.user + "@ciens.ucv.ve"
	            ActionCorreo.envio_adecuacion(email).deliver
	        end

	        if(cambio_act.estatus_id == 5)
	        	flash[:mensaje]="La adecuación se ha envíado a consejo de facultad"
	        else
	        	flash[:mensaje]="La adecuación se ha envíado a comision de investigacion"
	        end
     
    
	   	redirect_to controller:"iniciotutor", action: "listar_adecuaciones"
 	end 

	def mas_observaciones3 #mas obs de actividades del informe

		@adecuacion= Adecuacion.find(session[:adecuacion_id])
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


end