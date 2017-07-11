class InicioentidadController < ApplicationController
	layout 'ly_inicio_entidad'

	def index
		if session[:usuario_id] && session[:entidad]= true
			session[:adecuacion_id] = nil
			session[:plan_id] = nil
			session[:instructorName] = nil
			session[:informe_id]=nil
			@nombre = session[:nombre_usuario]
			print "NO HAY USUARIO"
			puts session[:entidad_id]
			if not @nombre
				print "NO HAY USUARIO"
			end
			@usu=Usuarioentidad.where(entidad_id: session[:entidad_id]).take
			@entidad_escuela_id= @usu.escuela_id
			@notificaciones1= []
		    if (session[:entidad_id] >= 7 && session[:entidad_id] <= 12)					#Caso de Comision de Investigación
		    	@notificaciones = Notificacion.where(actual: 3).all
		    	@notificaciones.each do |notificaciones|
			    	@tutor_escuela = Usuarioentidad.where(usuario_id: notificaciones.tutor_id).take
			    	puts @tutor_escuela.escuela_id
			    	puts @entidad_escuela_id
			    	puts notificaciones.actual
			    	if (@tutor_escuela.escuela_id == @entidad_escuela_id) #Caso de notificaciones del Comision de investigación 
			        	@notificaciones1.push(notificaciones)
			        end
		    	end
		    elsif (session[:entidad_id] >= 1 && session[:entidad_id] <= 6)
		    	@notificaciones = Notificacion.where(actual: 4).all
		    	@notificaciones.each do |notificaciones|
			    	@tutor_escuela = Usuarioentidad.where(usuario_id: notificaciones.tutor_id).take
			    	puts @tutor_escuela.escuela_id
			    	puts @entidad_escuela_id
			    	puts notificaciones.actual
			    	if (@tutor_escuela.escuela_id == @entidad_escuela_id) #Caso de notificaciones del Comision de investigación 
			        	@notificaciones1.push(notificaciones)
			        end
		    	end
		    elsif (session[:entidad_id] == 13)
		    	@notificaciones1 = Notificacion.where(actual: 5).all
		    end			
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def logout
		reset_session
		redirect_to controller: "forminst", action: "index"
	end

	def listar_adecuaciones
		if session[:usuario_id] && session[:entidad]== true
			session[:informe_id]=nil
			session[:adecuacion_id]=nil
				@nombre = session[:nombre_usuario]
				@usu=Usuarioentidad.where(entidad_id: session[:entidad_id]).take
				@entidad_escuela_id= @usu.escuela_id
				@adecuaciones = []
				@status = []
				@nombre_tutor = []
				@nombre_instructor = []
			if (session[:entidad_id] >= 7 && session[:entidad_id] <= 12)
			#Usuario comision
				@status_inv = EstatusAdecuacion.where(actual: 1,  estatus_id: [3,2,8,4,1,5,9]) #Estatus enviado a comision de investigacion
	
			else
				if (session[:entidad_id] >= 14 && session[:entidad_id] <= 17)
				#Consejo tecnico
					@status_inv = EstatusAdecuacion.where(actual: 1, estatus_id: [2,8,4,1,5,9]) #Estatus enviado a consejo tecnico
				else
					if (session[:entidad_id] >= 1 && session[:entidad_id] <= 6)
					#Consejo de escuela
						@status_inv = EstatusAdecuacion.where(actual: 1, estatus_id: [8,4,1,5,9]) #Estatus enviado a consejo escuela
					else
						if (session[:entidad_id] == 13)
						#Consejo de facultad
							@status_inv = EstatusAdecuacion.where(actual: 1, estatus_id: [4,1,5,9]) #Estatus enviado a consejo de facultad
							@entidad_escuela_id=nil
						
						end	
					end
				end
			end

			@status_inv.each do |si|

				@adec= Adecuacion.find(si.adecuacion_id)
				@pf = Planformacion.find(@adec.planformacion_id)
				if (session[:entidad_id] == 13)
					@adecuacion = true
					@adecuaciones.push(@adec)
					if(si.estatus_id==1)
						@st = "APROBADO POR CONSEJO DE FACULTAD"
					else
						if(si.estatus_id==2)
							@st = "ENVIADO A CONSEJO TÉCNICO"
						else
							if(si.estatus_id==3)
								@st = "ENVIADO A COMISION DE INVESTIGACIÓN"
							else
								if(si.estatus_id==4)
									@st = "ENVIADO A CONSEJO DE FACULTAD"
								else
									if(si.estatus_id==5)
										@st = "APROBADO CON OBSERVACIONES POR CONSEJO DE FACULTAD"
									else
										if(si.estatus_id==8)
											@st = "ENVIADO A CONSEJO DE ESCUELA"
										else
											if(si.estatus_id==9)
												@st = "RECHAZADO POR CONSEJO DE FACULTAD"
											end
										end
									end
								end
							end
						end
					end
					@status.push(@st)
					@nombre_tutor.push(Persona.where(usuario_id: @pf.tutor_id).take.nombres)
					@nombre_instructor.push(Persona.where(usuario_id: @pf.instructor_id).take.nombres)
				else

					@tutor_escuela = Usuarioentidad.where(usuario_id: @adec.tutor_id).take
					puts @tutor_escuela.escuela_id
					puts @entidad_escuela_id
					if @tutor_escuela.escuela_id == @entidad_escuela_id
						
						@adecuacion = true
						@adecuaciones.push(@adec)
						if(si.estatus_id==1)
							@st = "APROBADO POR CONSEJO DE FACULTAD"
						else
							if(si.estatus_id==2)
								@st = "ENVIADO A CONSEJO TÉCNICO"
							else
								if(si.estatus_id==3)
									@st = "ENVIADO A COMISION DE INVESTIGACIÓN"
								else
									if(si.estatus_id==4)
										@st = "ENVIADO A CONSEJO DE FACULTAD"
									else
										if(si.estatus_id==5)
											@st = "APROBADO CON OBSERVACIONES POR CONSEJO DE FACULTAD"
										else
											if(si.estatus_id==8)
												@st = "ENVIADO A CONSEJO DE ESCUELA"
											else
												if(si.estatus_id==9)
													@st = "RECHAZADO POR CONSEJO DE FACULTAD"
												end
											end
										end
									end
								end
							end
						end



						@status.push(@st)
						@nombre_tutor.push(Persona.where(usuario_id: @pf.tutor_id).take.nombres)
						@nombre_instructor.push(Persona.where(usuario_id: @pf.instructor_id).take.nombres)
					end
				end
			end			
		else
			redirect_to controller:"forminst", action: "index"
		end

	end

def ver_soporte
    @plan = Planformacion.where(id: session[:plan_id]).take
    @documents = []
    if !session[:informe_id].blank?
    	adec = Adecuacion.where(planformacion_id: session[:plan_id]).take
    	session[:adecuacion_id] = adec.id
      	@documents = Document.where(adecuacion_id: session[:adecuacion_id], informe_id: session[:informe_id]).all
		@bool_enviado = 0
		if (session[:entidad_id] >= 7 && session[:entidad_id] <= 12)
		#Usuario comision
			estatusI = EstatusInforme.where(informe_id: session[:informe_id], actual: 1).take #Estatus enviado a comision de investigacioni
			if(estatusI.estatus_id != 3)
			@bool_enviado = 1
			end
		else
			if (session[:entidad_id] >= 14 && session[:entidad_id] <= 17)
			#Consejo tecnico
				estatusI = EstatusInforme.where(informe_id: session[:informe_id], actual: 1).take
				if(estatusI.estatus_id != 2)
				@bool_enviado = 1
				end
			else
				if (session[:entidad_id] >= 1 && session[:entidad_id] <= 6)
				#Consejo de escuela
					estatusI = EstatusInforme.where(informe_id: session[:informe_id], actual: 1).take 
					if(estatusI.estatus_id != 8)
					@bool_enviado = 1 #Estatus enviado a consejo escuela
					
					end
				else
					if (session[:entidad_id] == 13)
					#Consejo de facultad
						estatusI = EstatusInforme.where(informe_id: session[:informe_id], actual: 1).take
						if(estatusI.estatus_id != 4)
						@bool_enviado = 1
						end
					end	
				end
			end
		end		    
	else
      @documents = Document.where(adecuacion_id: session[:adecuacion_id], informe_id: nil).all
      @bool_enviado = 0
		if (session[:entidad_id] >= 7 && session[:entidad_id] <= 12)
		#Usuario comision
			estatusI = EstatusAdecuacion.where(adecuacion_id: session[:adecuacion_id], actual: 1).take #Estatus enviado a comision de investigacioni
			if(estatusI.estatus_id != 3)
			@bool_enviado = 1
			end
		else
			if (session[:entidad_id] >= 14 && session[:entidad_id] <= 17)
			#Consejo tecnico
				estatusI = EstatusAdecuacion.where(adecuacion_id: session[:adecuacion_id], actual: 1).take
				if(estatusI.estatus_id != 2)
				@bool_enviado = 1
				end
			else
				if (session[:entidad_id] >= 1 && session[:entidad_id] <= 6)
				#Consejo de escuela
					estatusI = EstatusAdecuacion.where(adecuacion_id: session[:adecuacion_id], actual: 1).take 
					if(estatusI.estatus_id != 8)
					@bool_enviado = 1 #Estatus enviado a consejo escuela
					
					end
				else
					if (session[:entidad_id] == 13)
					#Consejo de facultad
						estatusI = EstatusAdecuacion.where(adecuacion_id: session[:adecuacion_id], actual: 1).take
						if(estatusI.estatus_id != 4)
						@bool_enviado = 1
						end
					end	
				end
			end
		end
    end
end

	def ver_detalles_adecuacion
		if session[:usuario_id] && session[:entidad]= true
			@nombre = session[:nombre_usuario]
			@modifique=false
			session[:informe_id] = nil
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
			
			@tutoresAnteriores = Instructortutor.where(instructor_id: session[:usuario_id], actual: 0)
			@adecuacion= Adecuacion.find(session[:adecuacion_id])
			@plan= Planformacion.find(@adecuacion.planformacion_id)
			session[:plan_id] = @plan.id
			@userentidad= Usuarioentidad.where(usuario_id: @plan.instructor_id).take
			if @userentidad.escuela_id == nil
				@userentidad.escuela_id=12
				@userentidad.save
				@escuela= Escuela.where(id: @userentidad.escuela_id).take
			else
				@escuela= Escuela.where(id: @userentidad.escuela_id).take
			end
			@instructor= Persona.where(usuario_id: @plan.instructor_id).take

			@bool_enviado = 0
			if (session[:entidad_id] >= 7 && session[:entidad_id] <= 12)
			#Usuario comision
				estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take #Estatus enviado a comision de investigacioni
				if(estatusI.estatus_id != 3)
				@bool_enviado = 1
				end

			else
				if (session[:entidad_id] >= 14 && session[:entidad_id] <= 17)
				#Consejo tecnico
					estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
					if(estatusI.estatus_id != 2)
					@bool_enviado = 1
					end
				else
					if (session[:entidad_id] >= 1 && session[:entidad_id] <= 6)
					#Consejo de escuela
						estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take 
						if(estatusI.estatus_id != 8)
						@bool_enviado = 1 #Estatus enviado a consejo escuela
						
						end
					else
						if (session[:entidad_id] == 13)
						#Consejo de facultad
							estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
							if(estatusI.estatus_id != 4)
							@bool_enviado = 1
							end
						end	
					end
				end
			end

			@nombre = session[:nombre_usuario]
			@adecuacion= Adecuacion.find(session[:adecuacion_id])
			@plan= Planformacion.find(@adecuacion.planformacion_id)
			@userentidad= Usuarioentidad.where(usuario_id: @plan.instructor_id).take
			if @userentidad.escuela_id == nil
				@userentidad.escuela_id=12
				@userentidad.save
				@escuela= Escuela.where(id: @userentidad.escuela_id).take
			else
				@escuela= Escuela.where(id: @userentidad.escuela_id).take
			end
			@persona= Persona.where(usuario_id: @plan.instructor_id).take
			@usuario= Usuario.find(@plan.instructor_id)
			@cpTutor= Persona.where(usuario_id: @plan.tutor_id).take
			@cpTutorEmail= Usuario.find(@plan.tutor_id).email

			@bool_enviado = 0
			if (session[:entidad_id] >= 7 && session[:entidad_id] <= 12)
			#Usuario comision
				estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take #Estatus enviado a comision de investigacioni
				if(estatusI.estatus_id != 3)
				@bool_enviado = 1
				end

			else
				if (session[:entidad_id] >= 14 && session[:entidad_id] <= 17)
				#Consejo tecnico
					estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
					if(estatusI.estatus_id != 2)
					@bool_enviado = 1
					end
				else
					if (session[:entidad_id] >= 1 && session[:entidad_id] <= 6)
					#Consejo de escuela
						estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take 
						if(estatusI.estatus_id != 8)
						@bool_enviado = 1 #Estatus enviado a consejo escuela
						
						end
					else
						if (session[:entidad_id] == 13)
						#Consejo de facultad
							estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
							if(estatusI.estatus_id != 4)
							@bool_enviado = 1
							end
						end	
					end
				end
			end

		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def detalles_adecuacion3
		if session[:usuario_id] && session[:entidad]= true
			@semestre = 1
			@iddoc= 'id_docencia'
			@docencia='docencia'
			@investigacion= 'investigacion'
			session[:informe_id] = nil
			@formacion= 'formacion'
			@extension= 'extension'
			@otra= 'otra' 
			@nombre = session[:nombre_usuario]
			@adecuacion= Adecuacion.find(session[:adecuacion_id])

			@plan= Planformacion.find(@adecuacion.planformacion_id)
			@actividadesadoc= []
			@actividadesainv= []
			@actividadesaext= []
			@actividadesafor= []
			@actividadesaotr= []
			@observaciont= []
			@j=0
			@est= EstatusAdecuacion.where(adecuacion_id: @adecuacion.id).take
			@revision= Revision.where(usuario_id: session[:usuario_id], adecuacion_id: @adecuacion.id, estatus_id: @est.estatus_id, informe_id: nil).take
			@actividadesa= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: 1).all
			@actividadesa.each do |actade| 

				@act= Actividad.find(actade.actividad_id)
				tipo= @act.tipo_actividad_id

				if(@revision!=nil && @revision != "")
			
					@obs= ObservacionActividadAdecuacion.where(adecuacionactividad_id: actade.id, revision_id: @revision.id).take
		       
			        if @obs==nil
			          	@observaciont.push("")
			        else
			          	@observaciont.push(@obs.observaciones)
			        end
			    end

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
			if (session[:entidad_id] >= 7 && session[:entidad_id] <= 12)
			#Usuario comision
				estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take #Estatus enviado a comision de investigacioni
				if(estatusI.estatus_id != 3)
				@bool_enviado = 1
				end

			else
				if (session[:entidad_id] >= 14 && session[:entidad_id] <= 17)
				#Consejo tecnico
					estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
					if(estatusI.estatus_id != 2)
					@bool_enviado = 1
					end
				else
					if (session[:entidad_id] >= 1 && session[:entidad_id] <= 6)
					#Consejo de escuela
						estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take 
						if(estatusI.estatus_id != 8)
						@bool_enviado = 1 #Estatus enviado a consejo escuela
						
						end
					else
						if (session[:entidad_id] == 13)
						#Consejo de facultad
							estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
							if(estatusI.estatus_id != 4)
							@bool_enviado = 1
							end
						end	
					end
				end
			end
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def detalles_adecuacion4
		if session[:usuario_id] && session[:entidad]= true
			@semestre = 2
			@iddoc= 'id_docencia'
			session[:informe_id] = nil
			@docencia='docencia'
			@investigacion= 'investigacion'
			@formacion= 'formacion'
			@extension= 'extension'
			@otra= 'otra' 
			@nombre = session[:nombre_usuario]
			@adecuacion= Adecuacion.find(session[:adecuacion_id])

			@plan= Planformacion.find(@adecuacion.planformacion_id)
			@actividadesadoc= []
			@actividadesainv= []
			@actividadesaext= []
			@actividadesafor= []
			@actividadesaotr= []
			@observaciont= []
			@j=0
			@est= EstatusAdecuacion.where(adecuacion_id: @adecuacion.id).take
			@revision= Revision.where(usuario_id: session[:usuario_id], adecuacion_id: @adecuacion.id, estatus_id: @est.estatus_id, informe_id: nil).take
			@actividadesa= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: 2).all
			@actividadesa.each do |actade| 

				@act= Actividad.find(actade.actividad_id)
				tipo= @act.tipo_actividad_id

				if(@revision!=nil && @revision != "")
			
					@obs= ObservacionActividadAdecuacion.where(adecuacionactividad_id: actade.id, revision_id: @revision.id).take
		       
			        if @obs==nil
			          	@observaciont.push("")
			        else
			          	@observaciont.push(@obs.observaciones)
			        end
			    end

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
			if (session[:entidad_id] >= 7 && session[:entidad_id] <= 12)
			#Usuario comision
				estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take #Estatus enviado a comision de investigacioni
				if(estatusI.estatus_id != 3)
				@bool_enviado = 1
				end

			else
				if (session[:entidad_id] >= 14 && session[:entidad_id] <= 17)
				#Consejo tecnico
					estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
					if(estatusI.estatus_id != 2)
					@bool_enviado = 1
					end
				else
					if (session[:entidad_id] >= 1 && session[:entidad_id] <= 6)
					#Consejo de escuela
						estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take 
						if(estatusI.estatus_id != 8)
						@bool_enviado = 1 #Estatus enviado a consejo escuela
						
						end
					else
						if (session[:entidad_id] == 13)
						#Consejo de facultad
							estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
							if(estatusI.estatus_id != 4)
							@bool_enviado = 1
							end
						end	
					end
				end
			end
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def detalles_adecuacion5
		if session[:usuario_id] && session[:entidad]= true
			@semestre = 3
			@iddoc= 'id_docencia'
			@docencia='docencia'
			@investigacion= 'investigacion'
			session[:informe_id] = nil
			@formacion= 'formacion'
			@extension= 'extension'
			@otra= 'otra' 
			@nombre = session[:nombre_usuario]
			@adecuacion= Adecuacion.find(session[:adecuacion_id])

			@plan= Planformacion.find(@adecuacion.planformacion_id)
			@actividadesadoc= []
			@actividadesainv= []
			@actividadesaext= []
			@actividadesafor= []
			@actividadesaotr= []
			@observaciont= []
			@j=0
			@est= EstatusAdecuacion.where(adecuacion_id: @adecuacion.id).take
			@revision= Revision.where(usuario_id: session[:usuario_id], adecuacion_id: @adecuacion.id, estatus_id: @est.estatus_id, informe_id: nil).take
			@actividadesa= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: 3).all
			@actividadesa.each do |actade| 

				@act= Actividad.find(actade.actividad_id)
				tipo= @act.tipo_actividad_id

				if(@revision!=nil && @revision != "")
			
					@obs= ObservacionActividadAdecuacion.where(adecuacionactividad_id: actade.id, revision_id: @revision.id).take
		       
			        if @obs==nil
			          	@observaciont.push("")
			        else
			          	@observaciont.push(@obs.observaciones)
			        end
			    end

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
			if (session[:entidad_id] >= 7 && session[:entidad_id] <= 12)
			#Usuario comision
				estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take #Estatus enviado a comision de investigacioni
				if(estatusI.estatus_id != 3)
				@bool_enviado = 1
				end

			else
				if (session[:entidad_id] >= 14 && session[:entidad_id] <= 17)
				#Consejo tecnico
					estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
					if(estatusI.estatus_id != 2)
					@bool_enviado = 1
					end
				else
					if (session[:entidad_id] >= 1 && session[:entidad_id] <= 6)
					#Consejo de escuela
						estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take 
						if(estatusI.estatus_id != 8)
						@bool_enviado = 1 #Estatus enviado a consejo escuela
						
						end
					else
						if (session[:entidad_id] == 13)
						#Consejo de facultad
							estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
							if(estatusI.estatus_id != 4)
							@bool_enviado = 1
							end
						end	
					end
				end
			end
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def detalles_adecuacion6
		if session[:usuario_id] && session[:entidad]= true
			@semestre = 4
			@iddoc= 'id_docencia'
			session[:informe_id] = nil
			@docencia='docencia'
			@investigacion= 'investigacion'
			@formacion= 'formacion'
			@extension= 'extension'
			@otra= 'otra' 
			@nombre = session[:nombre_usuario]
			@adecuacion= Adecuacion.find(session[:adecuacion_id])

			@plan= Planformacion.find(@adecuacion.planformacion_id)
			@actividadesadoc= []
			@actividadesainv= []
			@actividadesaext= []
			@actividadesafor= []
			@actividadesaotr= []
			@observaciont= []
			@j=0
			@est= EstatusAdecuacion.where(adecuacion_id: @adecuacion.id).take
			@revision= Revision.where(usuario_id: session[:usuario_id], adecuacion_id: @adecuacion.id, estatus_id: @est.estatus_id, informe_id: nil).take
			@actividadesa= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: 4).all
			@actividadesa.each do |actade| 

				@act= Actividad.find(actade.actividad_id)
				tipo= @act.tipo_actividad_id

				if(@revision!=nil && @revision != "")
			
					@obs= ObservacionActividadAdecuacion.where(adecuacionactividad_id: actade.id, revision_id: @revision.id).take
		       
			        if @obs==nil
			          	@observaciont.push("")
			        else
			          	@observaciont.push(@obs.observaciones)
			        end
			    end

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
			if (session[:entidad_id] >= 7 && session[:entidad_id] <= 12)
			#Usuario comision
				estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take #Estatus enviado a comision de investigacioni
				if(estatusI.estatus_id != 3)
				@bool_enviado = 1
				end

			else
				if (session[:entidad_id] >= 14 && session[:entidad_id] <= 17)
				#Consejo tecnico
					estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
					if(estatusI.estatus_id != 2)
					@bool_enviado = 1
					end
				else
					if (session[:entidad_id] >= 1 && session[:entidad_id] <= 6)
					#Consejo de escuela
						estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take 
						if(estatusI.estatus_id != 8)
						@bool_enviado = 1 #Estatus enviado a consejo escuela
						
						end
					else
						if (session[:entidad_id] == 13)
						#Consejo de facultad
							estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
							if(estatusI.estatus_id != 4)
							@bool_enviado = 1
							end
						end	
					end
				end
			end
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def detalles_adecuacion7
		if session[:usuario_id] && session[:entidad]= true
			@semestre = 5
			@iddoc= 'id_docencia'
			@docencia='docencia'
			@investigacion= 'investigacion'
			@obligatoria = 'obligatoria'
			session[:informe_id] = nil
			@formacion= 'formacion'
			@extension= 'extension'
			@otra= 'otra' 
			@nombre = session[:nombre_usuario]
			@adecuacion= Adecuacion.find(session[:adecuacion_id])

			@plan= Planformacion.find(@adecuacion.planformacion_id)
			@actividadesadoc= []
			@actividadesainv= []
			@actividadesaext= []
			@actividadesafor= []
			@actividadesaotr= []
			@actividadesaobli= []
			@observaciont= []
			@j=0
			@est= EstatusAdecuacion.where(adecuacion_id: @adecuacion.id).take
			@revision= Revision.where(usuario_id: session[:usuario_id], adecuacion_id: @adecuacion.id, estatus_id: @est.estatus_id, informe_id: nil).take
			@actividadesa= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: 5).all
			@actividadesa.each do |actade| 

				@act= Actividad.find(actade.actividad_id)
				tipo= @act.tipo_actividad_id

				if(@revision!=nil && @revision != "")
			
					@obs= ObservacionActividadAdecuacion.where(adecuacionactividad_id: actade.id, revision_id: @revision.id).take
		       
			        if @obs==nil
			          	@observaciont.push("")
			        else
			          	@observaciont.push(@obs.observaciones)
			        end
			    end

				
				if tipo==7
					puts "soy otro tipo de actividad"
					puts @act.actividad
					@actividadesaobli.push(@act)
				end
			end
			@bool_enviado = 0
			if (session[:entidad_id] >= 7 && session[:entidad_id] <= 12)
			#Usuario comision
				estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take #Estatus enviado a comision de investigacioni
				if(estatusI.estatus_id != 3)
				@bool_enviado = 1
				end

			else
				if (session[:entidad_id] >= 14 && session[:entidad_id] <= 17)
				#Consejo tecnico
					estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
					if(estatusI.estatus_id != 2)
					@bool_enviado = 1
					end
				else
					if (session[:entidad_id] >= 1 && session[:entidad_id] <= 6)
					#Consejo de escuela
						estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take 
						if(estatusI.estatus_id != 8)
						@bool_enviado = 1 #Estatus enviado a consejo escuela
						
						end
					else
						if (session[:entidad_id] == 13)
						#Consejo de facultad
							estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
							if(estatusI.estatus_id != 4)
							@bool_enviado = 1
							end
						end	
					end
				end
			end
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def listar_informes
	    if session[:usuario_id] && session[:entidad]= true
	    	session[:informe_id]=nil
	    	@nombre = session[:nombre_usuario]
			@usu=Usuarioentidad.where(entidad_id: session[:entidad_id]).take
			@entidad_escuela_id= @usu.escuela_id
			@informes = []
			@tipos= []
			@status = []
			@nombre_tutor = []
			@nombre_instructor = []
			if (session[:entidad_id] >= 7 && session[:entidad_id] <= 12)
			#Usuario comision
				@status_inv = EstatusInforme.where(actual: 1,  estatus_id: [3,2,8,4,1,5,9]) #Estatus enviado a comision de investigacion
	
			else
				if (session[:entidad_id] >= 14 && session[:entidad_id] <= 17)
				#Consejo tecnico
					@status_inv = EstatusInforme.where(actual: 1, estatus_id: [2,8,4,1,5,9]) #Estatus enviado a consejo tecnico
				else
					if (session[:entidad_id] >= 1 && session[:entidad_id] <= 6)
					#Consejo de escuela
						@status_inv = EstatusInforme.where(actual: 1, estatus_id: [8,4,1,5,9]) #Estatus enviado a consejo escuela
					else
						if (session[:entidad_id] == 13)
						#Consejo de facultad
							@status_inv = EstatusInforme.where(actual: 1, estatus_id: [4,1,5,9]) #Estatus enviado a consejo de facultad
							@entidad_escuela_id=nil
						
						end	
					end
				end
			end
			@status_inv.each do |si|
				@inf= Informe.find(si.informe_id)
				@pf = Planformacion.find(@inf.planformacion_id)
				@ppp = Persona.where(usuario_id: @pf.instructor_id).take.nombres
			      

				if (session[:entidad_id] == 13)
					@informe = true
					@informes.push(@inf)
					if(si.estatus_id==1)
						@st = "APROBADO POR CONSEJO DE FACULTAD"
					else
						if(si.estatus_id==2)
							@st = "ENVIADO A CONSEJO TÉCNICO"
						else
							if(si.estatus_id==3)
								@st = "ENVIADO A COMISION DE INVESTIGACIÓN"
							else
								if(si.estatus_id==4)
									@st = "ENVIADO A CONSEJO DE FACULTAD"
								else
									if(si.estatus_id==5)
										@st = "APROBADO CON OBSERVACIONES POR CONSEJO DE FACULTAD"
									else
										if(si.estatus_id==6)
                  							@st = "GUARDADO"
										else                  						
											if(si.estatus_id==8)
												@st = "ENVIADO A CONSEJO DE ESCUELA"
											else
												if(si.estatus_id==9)
												@st = "RECHAZADO POR CONSEJO DE FACULTAD"
												end
											end
										end
									end
								end
							end
						end
					end
					if @inf.tipo_id == 1
			          @tipos.push('Semestral')
			        else
			          if @inf.tipo_id ==2
			            @tipos.push('Anual')
			          else
			            if @inf.tipo_id==3
			              @tipos.push('Final')
			          	else
			          		@tipos.push('')  	
			            end
			          end
			        end
					@status.push(@st)
					@nombre_tutor.push(Persona.where(usuario_id: @pf.tutor_id).take.nombres)
					@nombre_instructor.push(Persona.where(usuario_id: @pf.instructor_id).take.nombres)
				else
					@tutor_escuela = Usuarioentidad.where(usuario_id: @inf.tutor_id).take
					if @tutor_escuela.escuela_id == @entidad_escuela_id
						@informe = true
						@informes.push(@inf)
						if @inf.tipo_id == 1
				          @tipos.push('Semestral')
				        else
				          if @inf.tipo_id ==2
				            @tipos.push('Anual')
				          else
				            if @inf.tipo_id==3
				              @tipos.push('Final')
				          	else
				          		@tipos.push('')  	
				            end
				          end
				        end
						if(si.estatus_id==1)
							@st = "APROBADO POR CONSEJO DE FACULTAD"
						else
							if(si.estatus_id==2)
								@st = "ENVIADO A CONSEJO TÉCNICO"
							else
								if(si.estatus_id==3)
									@st = "ENVIADO A COMISION DE INVESTIGACIÓN"
								else
									if(si.estatus_id==4)
										@st = "ENVIADO A CONSEJO DE FACULTAD"
									else
										if(si.estatus_id==5)
											@st = "APROBADO CON OBSERVACIONES POR CONSEJO DE FACULTAD"
										else
											if(si.estatus_id==8)
												@st = "ENVIADO A CONSEJO DE ESCUELA"
											else
												if(si.estatus_id==9)
												@st = "RECHAZADO POR CONSEJO DE FACULTAD"
												end
											end
										end
									end
								end
							end
						end
						@status.push(@st)
						@nombre_tutor.push(Persona.where(usuario_id: @pf.tutor_id).take.nombres)
						@nombre_instructor.push(Persona.where(usuario_id: @pf.instructor_id).take.nombres)
					end
				end
			end	

	    else
      		redirect_to controller:"forminst", action: "index"
    	end
  	end
	def ver_detalles_informe
	    if session[:usuario_id] && session[:entidad]= true
	      	@nombre = session[:nombre_usuario]
	      	if params[:informe_id]!=nil
	        	session[:informe_id]= params[:informe_id]
	      	end
	      	if !session[:informe_id].blank?
		      	@informe= Informe.find(session[:informe_id])
		      	session[:plan_id] = @informe.planformacion_id
		      	@est= EstatusInforme.where(informe_id: @informe.id, actual: 1).take
	    		@status= TipoEstatus.find(@est.estatus_id)
		      	@planformacion = Planformacion.find(@informe.planformacion_id)
		      	@persona = Persona.where(usuario_id: @planformacion.tutor_id).take
		      	@instructor = Persona.where(usuario_id: @planformacion.instructor_id).take
		      	puts @planformacion.tutor_id
				puts @planformacion.instructor_id
				puts @planformacion.tutor_id
				puts @planformacion.instructor_id
				puts @planformacion.tutor_id
				puts @planformacion.instructor_id
    			@periodo = @informe.fecha_inicio.to_s + " al " + @informe.fecha_fin.to_s

		      	if (@informe.numero == 1 || @informe.numero == 3)
		        	@nombre_informe= "PRIMER INFORME "
		        	session[:numero_informe]=1
		      	elsif (@informe.numero == 2 || @informe.numero == 6)
		         	@nombre_informe= "SEGUNDO INFORME "
		          	session[:numero_informe]=2
		        elsif @informe.numero == 4
	            	@nombre_informe= "TERCER INFORME "
	            	session[:numero_informe]=4
				elsif @informe.numero == 5
	            	@nombre_informe= "CUARTO INFORME "
	            	session[:numero_informe]=5
		      	end

		      	if @informe.tipo_id == 1
		        	@nombre_informe= @nombre_informe+"SEMESTRAL"
		      	else
		        	if @informe.tipo_id == 2
		          		@nombre_informe= @nombre_informe+"ANUAL"
		        	else
		          		@nombre_informe= "INFORME "+"FINAL"
		        	end
		      	end

		      	@estatus= EstatusInforme.where(informe_id: @informe.id, actual: 1).take
		      	@status= TipoEstatus.find(@estatus.estatus_id)
		      	@userentidad=Usuarioentidad.where(entidad_id: session[:entidad_id]).take
				@escuela= Escuela.find(@userentidad.escuela_id)
		      	session[:nombre_informe] = @nombre_informe.downcase.split.map(&:capitalize).join(' ')		##Capitalize every first word of the string
		      	session[:status_informe] = @status.concepto
		    else
			    flash[:info]= "Seleccione un informe"
			    redirect_to controller:"inicioentidad", action: "listar_informes"
			end	
	    else
	      redirect_to controller:"forminst", action: "index"
	    end

	    @bool_enviado = 0
		if (session[:entidad_id] >= 7 && session[:entidad_id] <= 12)
		#Usuario comision
			estatusI = EstatusInforme.where(informe_id: @informe.id, actual: 1).take #Estatus enviado a comision de investigacioni
			if(estatusI.estatus_id != 3)
			@bool_enviado = 1
			end

		else
			if (session[:entidad_id] >= 14 && session[:entidad_id] <= 17)
			#Consejo tecnico
				estatusI = EstatusInforme.where(informe_id: @informe.id, actual: 1).take
				if(estatusI.estatus_id != 2)
				@bool_enviado = 1
				end
			else
				if (session[:entidad_id] >= 1 && session[:entidad_id] <= 6)
				#Consejo de escuela
					estatusI = EstatusInforme.where(informe_id: @informe.id, actual: 1).take 
					if(estatusI.estatus_id != 8)
					@bool_enviado = 1 #Estatus enviado a consejo escuela
					
					end
				else
					if (session[:entidad_id] == 13)
					#Consejo de facultad
						estatusI = EstatusInforme.where(informe_id: @informe.id, actual: 1).take
						if(estatusI.estatus_id != 4)
						@bool_enviado = 1
						end
					end	
				end
			end
		end
	end


	def detalles_informe2
		@nombre = session[:nombre_usuario]
    	@informe= Informe.find(session[:informe_id])
    	@est= EstatusInforme.where(informe_id: @informe.id, actual: 1).take
    	@status= TipoEstatus.find(@est.estatus_id)
    	@adecuacion = Adecuacion.where(planformacion_id: @informe.planformacion_id).take
    	@modificar= false
    	if @est.estatus_id == 6
    	  @modificar=true
    	end
    	@docencia= "docencia"
    	@cp=0
    	@j= 0
    	@k=0
    	@actividadesa= InformeActividad.where(informe_id: @informe.id).all
    	@actividadesadoc= []
    	@actividadesainv= []
    	@actividadesaext= []
    	@actividadesafor= []
    	@actividadesaotr= []
    	@actividadesaobli= []
    	@resultados= []
    	@resultados2= ""
    	@resultados2a= []
    	@resultados2b= []
    	@actividadese= []
    	@observaciont= []
    	@revision= Revision.where(informe_id: @informe.id, usuario_id: session[:usuario_id], adecuacion_id: @adecuacion.id).take
    	@actividadesa.each do |actade| 
    		if @resultados2b != []
    			@resultados2b= Array.new(0) { |i|  }
    		end
	      	if actade.actividad_id == nil #Es el caso que es un resultado no contemplado en el plan de formacion o un avancwe de postgrado
	        	@res= Resultado.where(informe_actividad_id: actade.id).all
	        	@resultados.push(@res)
	        	@actividadese.push("")
	        	puts "Heyyyyyyyyyyyyyyyyyy"
	        	@res.each do |cpresultado| 
		        	@cparray = ["a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a"]
		        	@cparray[0] = cpresultado.titulo
		        	@cparray[1] = cpresultado.autor
		        	@cparray[2] = cpresultado.nombre_capitulo
		        	@cparray[3] = cpresultado.autor_capitulo
		        	@cparray[4] = cpresultado.dia
		        	@cparray[5] = cpresultado.mes
		        	@cparray[6] = cpresultado.ano
		        	@cparray[7] = cpresultado.ciudad
		        	@cparray[8] = cpresultado.estado
		        	@cparray[9] = cpresultado.pais
		        	@cparray[10] = cpresultado.organizador
		        	@cparray[11] = cpresultado.duracion
		        	@cparray[12] = cpresultado.editor
		        	@cparray[13] = cpresultado.titulo_libro
		        	@cparray[14] = cpresultado.autor_libro
		        	@cparray[15] = cpresultado.nombre_revista
		        	@cparray[16] = cpresultado.nombre_periodico
		        	@cparray[17] = cpresultado.nombre_acto
		        	@cparray[18] = cpresultado.paginas
		        	@cparray[19] = cpresultado.nombre_paginaw
		        	@cparray[20] = cpresultado.sitio_paginaw
		        	@cparray[21] = cpresultado.infoafiliaion
		        	@cparray[22] = cpresultado.cptipo
		        	@cparray[23] = cpresultado.nombre
		        	@cparray[24] = cpresultado.ISSN_impreso
		        	@cparray[25] = cpresultado.ISSN_electro
		        	@cparray[26] = cpresultado.volumen
		        	@cparray[27] = cpresultado.edicion
		        	@cparray[28] = cpresultado.DOI
		        	@cparray[29] = cpresultado.ISBN
		        	@cparray[30] = cpresultado.universidad
		        	@cparray[31] = cpresultado.url
		        	puts "holaaaaaaaaaaaaaa"
		       		if !@cparray.blank?
			        	@noemptyarray = @cparray - ["", nil]
			        	if !@resultados2
				        	@noemptyarray = @cparray - ["", nil]
				        	if !@noemptyarray.join(',').blank?
				        		puts @noemptyarray.join(',')
					        	@resultados2 = @noemptyarray.join(',')
					        	puts "a"
					        	puts @resultados2
					        end
				        else
				        	@noemptyarray = @cparray - ["", nil]
				        	if !@noemptyarray.join(',').blank?
					        	puts @noemptyarray.join(',')
					        	@resultados2 = @noemptyarray.join(',')
					        	puts "b"
					        	puts @resultados2
				        	end
			        	end
			        	@resultados2b.push(@resultados2)
		        	end

			    end
			    @resultados2a.push(@resultados2b)

	        	if @revision == nil || @revision == ""
		        	@obs=nil
		        else
		        	@obs= ObservacionActividadInforme.where(informe_actividad_id: actade.id, revision_id: @revision.id).take
		        end	        
		        if @obs==nil
		          	@observaciont.push("")
		        else
		          	@observaciont.push(@obs.observaciones)
		        end

	     	else
		        @act= Actividad.find(actade.actividad_id)
		        tipo= @act.tipo_actividad_id
		        @res= Resultado.where(informe_actividad_id: actade.id).all
	        	puts "HOLAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
	        	puts actade.id
		        if !@res.blank?
		          	@resultados.push(@res)
		        	@res.each do |cpresultado| 
			        	@cparray = ["a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a"]
			        	@cparray[0] = cpresultado.titulo
			        	@cparray[1] = cpresultado.autor
			        	@cparray[2] = cpresultado.nombre_capitulo
			        	@cparray[3] = cpresultado.autor_capitulo
			        	@cparray[4] = cpresultado.dia
			        	@cparray[5] = cpresultado.mes
			        	@cparray[6] = cpresultado.ano
			        	@cparray[7] = cpresultado.ciudad
			        	@cparray[8] = cpresultado.estado
			        	@cparray[9] = cpresultado.pais
			        	@cparray[10] = cpresultado.organizador
			        	@cparray[11] = cpresultado.duracion
			        	@cparray[12] = cpresultado.editor
			        	@cparray[13] = cpresultado.titulo_libro
			        	@cparray[14] = cpresultado.autor_libro
			        	@cparray[15] = cpresultado.nombre_revista
			        	@cparray[16] = cpresultado.nombre_periodico
			        	@cparray[17] = cpresultado.nombre_acto
			        	@cparray[18] = cpresultado.paginas
			        	@cparray[19] = cpresultado.nombre_paginaw
			        	@cparray[20] = cpresultado.sitio_paginaw
			        	@cparray[21] = cpresultado.infoafiliaion
			        	@cparray[22] = cpresultado.cptipo
			        	@cparray[23] = cpresultado.nombre
			        	@cparray[24] = cpresultado.ISSN_impreso
			        	@cparray[25] = cpresultado.ISSN_electro
			        	@cparray[26] = cpresultado.volumen
			        	@cparray[27] = cpresultado.edicion
			        	@cparray[28] = cpresultado.DOI
			        	@cparray[29] = cpresultado.ISBN
			        	@cparray[30] = cpresultado.universidad
			        	@cparray[31] = cpresultado.url
			        	puts "holaaaaaaaaaaaaaa"
			       		if !@cparray.blank?
				        	@noemptyarray = @cparray - ["", nil]
				        	if !@resultados2
					        	@noemptyarray = @cparray - ["", nil]
					        	if !@noemptyarray.join(',').blank?
					        		puts @noemptyarray.join(',')
						        	@resultados2 = @noemptyarray.join(',')
						        	puts "a"
						        	puts @resultados2
						        end
					        else
					        	@noemptyarray = @cparray - ["", nil]
					        	if !@noemptyarray.join(',').blank?
						        	puts @noemptyarray.join(',')
						        	@resultados2 = @noemptyarray.join(',')
						        	puts "b"
						        	puts @resultados2
					        	end
				        	end
				        	@resultados2b.push(@resultados2)
			        	end
			        end
		        else
		          	@resultados.push(nil)
		        end
		        @resultados2a.push(@resultados2b)
		        @ae= ActividadEjecutada.where(informe_actividad_id: actade.id).take
		        if @ae==nil || @ae== ""
		        	
		        	@actividadese.push("")
		        else
		        	
		        puts "ACAAAAAAAAAAAAAAAAAAA!!!!!!!"
		        puts actade.id
		        	@actividadese.push(@ae)
		        end

		        if @revision == nil || @revision == ""
		        	@obs=nil
		        else
		        	@obs= ObservacionActividadInforme.where(informe_actividad_id: actade.id, revision_id: @revision.id).take
		        end

		        if @obs==nil
		          	@observaciont.push("")
		        else
		          	@observaciont.push(@obs.observaciones)
		        end
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
		                  		elsif tipo==7
		                  			@actividadesaobli.push(@act)
		                		end
		             		end
		            	end
		          	end
		        end
      		end
    	end
    	 @bool_enviado = 0
		if (session[:entidad_id] >= 7 && session[:entidad_id] <= 12)
		#Usuario comision
			estatusI = EstatusInforme.where(informe_id: @informe.id, actual: 1).take #Estatus enviado a comision de investigacioni
			if(estatusI.estatus_id != 3)
			@bool_enviado = 1
			end

		else
			if (session[:entidad_id] >= 14 && session[:entidad_id] <= 17)
			#Consejo tecnico
				estatusI = EstatusInforme.where(informe_id: @informe.id, actual: 1).take
				if(estatusI.estatus_id != 2)
				@bool_enviado = 1
				end
			else
				if (session[:entidad_id] >= 1 && session[:entidad_id] <= 6)
				#Consejo de escuela
					estatusI = EstatusInforme.where(informe_id: @informe.id, actual: 1).take 
					if(estatusI.estatus_id != 8)
					@bool_enviado = 1 #Estatus enviado a consejo escuela
					
					end
				else
					if (session[:entidad_id] == 13)
					#Consejo de facultad
						estatusI = EstatusInforme.where(informe_id: @informe.id, actual: 1).take
						if(estatusI.estatus_id != 4)
						@bool_enviado = 1
						end
					end	
				end
			end
		end
 	end

	def vista_previa1  
	  if !session[:informe_id].blank?
	    @informe= Informe.find(session[:informe_id])
	    @TipoSemestre=TipoInforme.where(id: @informe.tipo_id).take
	    @fechaActual = Date.current.to_s
	    @plan= Planformacion.find(session[:plan_id])
	    @fechaConcurso = @plan.fecha_inicio
	    @usere= Usuarioentidad.where(usuario_id: @plan.instructor_id).take
	    @escuela= Escuela.find(@usere.escuela_id)
	    @adecuacion= Adecuacion.where(planformacion_id: @plan.id).take
	    @adscripcion_docencia= @plan.adscripcion_docencia
	    @adscripcion_investigacion= @plan.adscripcion_investigacion
	    @persona= Persona.where(usuario_id: @plan.instructor_id).take
	    @cpinstruccion = @persona.grado_instruccion
	    @user = Usuario.find(@plan.instructor_id)
	    @tutor = Persona.where(usuario_id: @plan.tutor_id).take
    	@periodo = @informe.fecha_inicio.to_s + " al " + @informe.fecha_fin.to_s

	    @docencia='docencia'
	    @investigacion= 'investigacion'
	    @formacion= 'formacion'
	    @obligatoria= 'obligatoria'
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
	          if @informe.numero == 1
	            @resActi= InformeActividad.where(informe_id: @informe.id, actividad_id: @act.id).take
	            puts "HELLOOOOO"
	            @res= Resultado.where(informe_actividad_id: @resActi.id).all
	            puts @res
	          end
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

	    @actividades5obli= []
	    @actividades5= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: 5).all
	    @actividades5.each do |actade| 
	      @act= Actividad.find(actade.actividad_id)
	      tipo= @act.tipo_actividad_id
          if tipo==7
            puts "soy otro tipo de actividad"
            puts @act.actividad
            @actividades5obli.push(@act)
          end
	    end

	    @bool_enviado = 0
	    estatus_informe = EstatusInforme.where(informe_id: @informe.id, actual: 1).take
	    if (estatus_informe.estatus_id != 6 && estatus_informe.estatus_id != 5)
	      @bool_enviado = 1
	    end
	    @j = 0
	    @i = 0
	    @actividadesa= InformeActividad.where(informe_id: @informe.id).all
	    @actividadesadoc= []
	    @actividadesainv= []
	    @actividadesaext= []
	    @actividadesafor= []
	    @actividadesaotr= []
	    @actividadesaobli= []
	    @resultados= []
	    @actividadese= []
	    @observaciont= []
	    @resultTP = []
	    @resultPP = []
	    @resultPIT = []
	    @resultO = []
	    @resultAEC = []
	    @resultOEC = []
	    @resultDCS = []    
	    @actividadesa.each do |actade| 
	      @resultados2 = ""
	      @res= Resultado.where(informe_actividad_id: actade.id).all
	      if actade.actividad_id == nil #Es el caso que es un resultado no contemplado en el plan de formacion o un avancwe de postgrado
	        if !@res.blank?
	          @res.each do |res|
	            @resultados2 = ""
	            @cparray = ["a", "a", "a", "a", "a", "a", "a", "a", "a","a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a"]
	            @cparray[0] = res.titulo.capitalize
	            @cparray[1] = res.autor.capitalize
	            @cparray[2] = res.nombre_capitulo.to_s.capitalize
	            @cparray[3] = res.autor_capitulo.to_s.capitalize
	            @cparray[4] = res.dia
	            @cparray[5] = res.mes
	            @cparray[6] = res.ano
	            @cparray[7] = res.ciudad.to_s.capitalize
	            @cparray[8] = res.estado.to_s.capitalize
	            @cparray[9] = res.pais.to_s.capitalize
	            @cparray[10] = res.organizador.to_s.capitalize
	            @cparray[11] = res.duracion.to_s.capitalize
	            @cparray[12] = res.editor.to_s.capitalize
	            @cparray[13] = res.titulo_libro.to_s.capitalize
	            @cparray[14] = res.autor_libro.to_s.capitalize
	            @cparray[15] = res.nombre_revista.to_s.capitalize
	            @cparray[16] = res.nombre_periodico.to_s.capitalize
	            @cparray[17] = res.nombre_acto.to_s.capitalize
	            @cparray[18] = res.paginas
	            @cparray[19] = res.nombre_paginaw.to_s.capitalize
	            @cparray[20] = res.sitio_paginaw
	            @cparray[21] = res.infoafiliaion.to_s.capitalize
	            @cparray[22] = res.cptipo.to_s.capitalize
	            @cparray[23] = res.nombre.to_s.capitalize
	            @cparray[24] = res.ISSN_impreso.to_s.capitalize
	            @cparray[25] = res.ISSN_electro.to_s.capitalize
	            @cparray[26] = res.volumen.to_s.capitalize
	            @cparray[27] = res.edicion.to_s.capitalize
	            @cparray[28] = res.DOI
	            @cparray[29] = res.ISBN
	            @cparray[30] = res.universidad.to_s.capitalize
	            @cparray[31] = res.url
	            if !@cparray.blank?
	              @noemptyarray = @cparray - ["", nil]
	              if !@resultados2
	                @noemptyarray = @cparray - ["", nil]
	                if !@noemptyarray.join(',').blank?
	                  puts @noemptyarray.join(',')
	                  @resultados2 = "* " + @noemptyarray
	                  puts "a"
	                  puts @resultados2
	                end
	              else
	                @noemptyarray = @cparray - ["", nil]
	                if !@noemptyarray.join(',').blank?
	                  puts @noemptyarray.join(', ')
	                  @resultados2 = @resultados2 + @noemptyarray.join(', ')
	                  puts "b"
	                  puts @resultados2
	                end
	              end
	            end
	            if res.tipo_resultado_id == 1
	              @resultTP.push(@resultados2)
	            elsif res.tipo_resultado_id == 2
	              @resultPP.push(@resultados2)
	            elsif res.tipo_resultado_id == 3
	              @resultPIT.push(@resultados2)
	            elsif res.tipo_resultado_id == 4
	              @resultO.push(@resultados2)
	            elsif res.tipo_resultado_id == 5
	              @resultAEC.push(@resultados2)
	            elsif res.tipo_resultado_id == 6
	              @resultOEC.push(@resultados2)
	            elsif res.tipo_resultado_id == 7
	              @resultDCS.push(@resultados2)
	            end
	            @resultados.push(res)
	          end
	        end
	      else
	        @act= Actividad.find(actade.actividad_id)
	        tipo= @act.tipo_actividad_id
	        if !@res.blank?
	          @res.each do |res|
	            @resultados2 = ""
	            @cparray = ["a", "a", "a", "a", "a", "a", "a", "a", "a","a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a"]
	            @cparray[0] = res.titulo.capitalize
	            @cparray[1] = res.autor.capitalize
	            @cparray[2] = res.nombre_capitulo.to_s.capitalize
	            @cparray[3] = res.autor_capitulo.to_s.capitalize
	            @cparray[4] = res.dia
	            @cparray[5] = res.mes
	            @cparray[6] = res.ano
	            @cparray[7] = res.ciudad.to_s.capitalize
	            @cparray[8] = res.estado.to_s.capitalize
	            @cparray[9] = res.pais.to_s.capitalize
	            @cparray[10] = res.organizador.to_s.capitalize
	            @cparray[11] = res.duracion.to_s.capitalize
	            @cparray[12] = res.editor.to_s.capitalize
	            @cparray[13] = res.titulo_libro.to_s.capitalize
	            @cparray[14] = res.autor_libro.to_s.capitalize
	            @cparray[15] = res.nombre_revista.to_s.capitalize
	            @cparray[16] = res.nombre_periodico.to_s.capitalize
	            @cparray[17] = res.nombre_acto.to_s.capitalize
	            @cparray[18] = res.paginas
	            @cparray[19] = res.nombre_paginaw.to_s.capitalize
	            @cparray[20] = res.sitio_paginaw
	            @cparray[21] = res.infoafiliaion.to_s.capitalize
	            @cparray[22] = res.cptipo.to_s.capitalize
	            @cparray[23] = res.nombre.to_s.capitalize
	            @cparray[24] = res.ISSN_impreso.to_s.capitalize
	            @cparray[25] = res.ISSN_electro.to_s.capitalize
	            @cparray[26] = res.volumen.to_s.capitalize
	            @cparray[27] = res.edicion.to_s.capitalize
	            @cparray[28] = res.DOI
	            @cparray[29] = res.ISBN
	            @cparray[30] = res.universidad.to_s.capitalize
	            @cparray[31] = res.url
	            if !@cparray.blank?
	              @noemptyarray = @cparray - ["", nil]
	              if !@resultados2
	                @noemptyarray = @cparray - ["", nil]
	                if !@noemptyarray.join(',').blank?
	                  puts @noemptyarray.join(',')
	                  @resultados2 = "* " + @noemptyarray
	                  puts "a"
	                  puts @resultados2
	                end
	              else
	                @noemptyarray = @cparray - ["", nil]
	                if !@noemptyarray.join(',').blank?
	                  puts @noemptyarray.join(', ')
	                  @resultados2 = @resultados2 + @noemptyarray.join(', ')
	                  puts "b"
	                  puts @resultados2
	                end
	              end
	            end
	            if res.tipo_resultado_id == 1
	              @resultTP.push(@resultados2)
	            elsif res.tipo_resultado_id == 2
	              @resultPP.push(@resultados2)
	            elsif res.tipo_resultado_id == 3
	              @resultPIT.push(@resultados2)
	            elsif res.tipo_resultado_id == 4
	              @resultO.push(@resultados2)
	            elsif res.tipo_resultado_id == 5
	              @resultAEC.push(@resultados2)
	            elsif res.tipo_resultado_id == 6
	              @resultOEC.push(@resultados2)
	            elsif res.tipo_resultado_id == 7
	              @resultDCS.push(@resultados2)
	            end
	            @resultados.push(res)
	          end
	        end
	      end
	      @ae= ActividadEjecutada.where(informe_actividad_id: actade.id).take
	      @actividadese.push(@ae)
	      @obs= ObservacionTutor.where(informe_actividad_id: actade.id).take
	      if @obs==nil
	        @observaciont.push("")
	      else
	        @observaciont.push(@obs.observaciones)
	      end
	      if tipo==1
	        @actividadesadoc.push(@act)
	      elsif tipo==2
	        @actividadesainv.push(@act)
	      elsif tipo==3
	        @actividadesaext.push(@act)
	      elsif tipo==4
	        @actividadesafor.push(@act)
	      elsif tipo==5
	        @actividadesaotr.push(@act)
	      elsif tipo==7
	        @actividadesaobli.push(@act)
	      end
	    end
	    @bool_enviado = 0
		if (session[:entidad_id] >= 7 && session[:entidad_id] <= 12)
		#Usuario comision
			estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take #Estatus enviado a comision de investigacioni
			if(estatusI.estatus_id != 3)
			@bool_enviado = 1
			end

		else
			if (session[:entidad_id] >= 14 && session[:entidad_id] <= 17)
			#Consejo tecnico
				estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
				if(estatusI.estatus_id != 2)
				@bool_enviado = 1
				end
			else
				if (session[:entidad_id] >= 1 && session[:entidad_id] <= 6)
				#Consejo de escuela
					estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take 
					if(estatusI.estatus_id != 8)
					@bool_enviado = 1 #Estatus enviado a consejo escuela
					
					end
				else
					if (session[:entidad_id] == 13)
					#Consejo de facultad
						estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
						if(estatusI.estatus_id != 4)
						@bool_enviado = 1
						end
					end	
				end
			end
		end
		else
			flash[:info]="Selecciona un informe"
			redirect_to controller: "inicioentidad", action: "listar_informes"
		end
	end

 	def guardar_observaciones
 		if session[:usuario_id] && session[:entidad]= true
 
 			@informe = Informe.find(session[:informe_id])
 			@adecuacion = Adecuacion.where(planformacion_id: @informe.planformacion_id).take
 			@estatus = EstatusInforme.where(informe_id: @informe.id, actual: 1).take
		    @cant_doc = params[:cant_docencia].to_i
		    @cant_inv = params[:cant_investigacion].to_i
		    @cant_for = params[:cant_formacion].to_i
		    @cant_ext = params[:cant_extension].to_i
		    @cant_otr = params[:cant_otra].to_i
		    @cant_obli = params[:cant_obligatoria].to_i
		    @cant_result= params[:cant_result].to_i
		    @informe.opinion_tutor = params[:opinion]
		    @informe.conclusiones = params[:conclusiones]
		    #@informe.save

	       revision= Revision.where(informe_id: @informe.id, usuario_id: session[:usuario_id], adecuacion_id: @adecuacion.id, estatus_id: @estatus.estatus_id).take
	        if(revision == nil || revision =="")

		        revision = Revision.new
		        revision.informe_id = @informe.id
	    	    revision.usuario_id = session[:usuario_id]
	    	    revision.adecuacion_id = @adecuacion.id
	        	revision.fecha =  Time.now
	        	revision.estatus_id = @estatus.estatus_id
	        	revision.save
			else
				revision.fecha =  Time.now
	        	revision.save

        	end 


		 	#Comienza actividades de docencia
		      	j=0
		      	i=:doc.to_s+j.to_s
		      	@act = params[i].to_i
		      	while j <  @cant_doc
		        	ia = InformeActividad.where(informe_id: @informe.id,actividad_id: @act).take     
		        	observacion =:observacion.to_s+@act.to_s
		        	
		          		oa = ObservacionActividadInforme.where(informe_actividad_id: ia, revision_id: revision.id).take
		          		if(oa == nil || oa =="")
				          	oa = ObservacionActividadInforme.new
				          	oa.informe_actividad_id = ia.id
				          	oa.revision_id =  revision.id
				          	oa.observaciones = params[observacion]
				          	oa.save
				        else
				       		oa.observaciones = params[observacion]
				       		oa.save
				       	end
		        	  j= j+1
			        i=:doc.to_s+j.to_s
			        @act= params[i].to_i
			    end

		   	#Comienza actividades de investigacion
		      	j=0
		      	i=:inv.to_s+j.to_s
		      	@act = params[i].to_i
		      	k=:result.to_s+j.to_s
		      	@result= params[k].to_i
		      	while j <  @cant_inv
		        	ia = InformeActividad.where(informe_id: @informe.id,actividad_id: @act).take
					observacion =:observacion.to_s+@act.to_s				
	        
	          		oa = ObservacionActividadInforme.where(informe_actividad_id: ia, revision_id: revision.id).take
		   	       	if(oa == nil || oa =="")
			          	oa = ObservacionActividadInforme.new
			          	oa.informe_actividad_id = ia.id
			          	oa.revision_id =  revision.id
			          	oa.observaciones = params[observacion]
			          	oa.save
			       	else
			       		 oa.observaciones = params[observacion]
			       		 oa.save
			       	end
		        


			        j=j+1
			        i=:inv.to_s+j.to_s
			        @act= params[i].to_i
		      	end

		    #Comienza actividades de formación
		      	j=0
		      	i=:for.to_s+j.to_s
		      	@act = params[i].to_i
		      	while j <  @cant_for
		        	ia = InformeActividad.where(informe_id: @informe.id,actividad_id: @act).take
		        	observacion =:observacion.to_s+@act.to_s

		      
		          	oa = ObservacionActividadInforme.where(informe_actividad_id: ia, revision_id: revision.id).take

		          	if(oa == nil || oa== "")
		          		oa = ObservacionActividadInforme.new
		          		oa.informe_actividad_id = ia.id
		          		oa.revision_id =  revision.id
		          		oa.observaciones = params[observacion]
		          		oa.save
		          		
		       		else
			       		
			       		oa.observaciones = params[observacion]
			       		oa.save
			       		
			       	end
			  
		        	j= j+1
		        	i=:for.to_s+j.to_s
		        	@act= params[i].to_i
		      	end

		    #Resultado de avances de postgrado

		        @id_resultado= params[:postgradoRest].to_i

		        if @id_resultado !=0 && @id_resultado != nil

			 
			        ia = InformeActividad.where(informe_id: @informe.id, resultado_id:  @id_resultado).take     

			        puts ia 
		          	oa = ObservacionActividadInforme.where(informe_actividad_id: ia.id, revision_id: revision.id).take
		          	if(oa == nil || oa =="")
			          	oa = ObservacionActividadInforme.new
			          	oa.informe_actividad_id = ia.id
			          	oa.revision_id =  revision.id
			          	oa.observaciones = params[:observacionPost].to_s
			          	oa.save	
			       	else
			       		oa.observaciones = params[:observacionPost].to_s
			       		oa.save
			       	end
			    end
	        
		    #Comienzan actividades de extensión
		
		      	j=0
		      	i=:ext.to_s+j.to_s
		      	@act = params[i].to_i
		      	while j <  @cant_ext
		        	ia = InformeActividad.where(informe_id: @informe.id, actividad_id: @act).take
		        	observacion =:observacion.to_s+@act.to_s
		        	
		          		oa = ObservacionActividadInforme.where(informe_actividad_id: ia, revision_id: revision.id).take
			          	if(oa == nil || oa =="")
			          		oa = ObservacionActividadInforme.new
			          		oa.informe_actividad_id = ia.id
			          		oa.revision_id =  revision.id
			          		oa.observaciones = params[observacion]
			          		oa.save
			       		else
				       		oa.observaciones = params[observacion]
				       		oa.save
				       	end
		        	
			        j= j+1
			        i=:ext.to_s+j.to_s
			        @act= params[i].to_i
			    end

			#Comienza actividades de docencia
				puts "comienza actividades de docencia"
				puts @cant_obli
		      	j=0
			    i=:obli.to_s+j.to_s
			    @act = params[i].to_i
		      	while j <  @cant_obli
		      		puts j
		        	ia = InformeActividad.where(informe_id: @informe.id,actividad_id: @act).take     
		        	observacion =:observacion.to_s+@act.to_s
		        	
		          		oa = ObservacionActividadInforme.where(informe_actividad_id: ia, revision_id: revision.id).take
		          		if(oa == nil || oa =="")
				          	oa = ObservacionActividadInforme.new
				          	oa.informe_actividad_id = ia.id
				          	oa.revision_id =  revision.id
				          	oa.observaciones = params[observacion]
				          	oa.save
				        else
				       		oa.observaciones = params[observacion]
				       		oa.save
				       	end
		        	j= j+1
			        i=:obli.to_s+j.to_s
			        @act= params[i].to_i
			    end


			#Comienzan Otras actividades
				puts "comienza otras actividades"
		      	j=0
		      	i=:otr.to_s+j.to_s
		      	@act = params[i].to_i

		      	while j <  @cant_otr
		        	ia = InformeActividad.where(informe_id: @informe.id,actividad_id: @act).take
		        	observacion =:observacion.to_s+@act.to_s
		        
		          		oa = ObservacionActividadInforme.where(informe_actividad_id: ia, revision_id: revision.id).take
			          	if(oa == nil || oa =="")
			          		oa = ObservacionActividadInforme.new
			          		oa.informe_actividad_id = ia.id
			          		oa.revision_id =  revision.id
			          		oa.observaciones = params[observacion]
			          		oa.save
			       		else
				       		oa.observaciones = params[observacion]
				       		oa.save
				       	end
		        	
			        j= j+1
			        i=:otr.to_s+j.to_s
			        @act= params[i].to_i
			    end

	      	#Resultado actividades no contempladas
		 
		        @id_resultado= params[:noConRest].to_i
		       	if @id_resultado !=0 && @id_resultado != nil
			        ia = InformeActividad.where(informe_id: @informe.id, resultado_id:  @id_resultado).take
		          	oa = ObservacionActividadInforme.where(informe_actividad_id: ia.id, revision_id: revision.id).take
		          	if(oa == nil || oa =="")
			          	oa = ObservacionActividadInforme.new
			          	oa.informe_actividad_id = ia.id
			          	oa.revision_id =  revision.id
			          	oa.observaciones = params[:observacionNoCon].to_s
			          	oa.save	
			       	else
			       		oa.observaciones = params[:observacionNoCon].to_s
			       		oa.save
			       	end
			    end

	      	flash[:success]="Se han creado y/o modificado las observaciones satisfactoriamente"
	      	redirect_to controller:"inicioentidad", action: "detalles_informe2"
 		end
 	end

	def logout
		reset_session
		redirect_to controller: "forminst", action: "index"
	end

	def mas_observaciones
		@boolobs= 0
		@booltutor = 0
		@informe_id = params[:informe_id].to_i
		@actividad_id = params[:actividad_id].to_i
		ia = InformeActividad.where(informe_id: @informe_id, actividad_id: @actividad_id).take 


		@observaciones = ObservacionActividadInforme.where(informe_actividad_id: ia.id).all

		@observaciones.each do |obs|
			
			if(obs.observaciones != "")
			@boolobs = 1
			end
		end
			
		@observaciones.each do |obs|

			rev =  Revision.find(obs.revision_id)
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

		@obs_t= ObservacionTutor.where(informe_actividad_id: ia.id).take
		
		if(@obs_t != nil && @obs_t != "")
			@obs_tutor = @obs_t.observaciones
			@booltutor = 1
		end

		@bool_enviado = 0
		if (session[:entidad_id] >= 7 && session[:entidad_id] <= 12)
		#Usuario comision
			estatusI = EstatusInforme.where(informe_id: @informe_id, actual: 1).take #Estatus enviado a comision de investigacioni
			if(estatusI.estatus_id != 3)
			@bool_enviado = 1
			end

		else
			if (session[:entidad_id] >= 14 && session[:entidad_id] <= 17)
			#Consejo tecnico
				estatusI = EstatusInforme.where(informe_id: @informe_id, actual: 1).take
				if(estatusI.estatus_id != 2)
				@bool_enviado = 1
				end
			else
				if (session[:entidad_id] >= 1 && session[:entidad_id] <= 6)
				#Consejo de escuela
					estatusI = EstatusInforme.where(informe_id: @informe_id, actual: 1).take 
					if(estatusI.estatus_id != 8)
					@bool_enviado = 1 #Estatus enviado a consejo escuela
					
					end
				else
					if (session[:entidad_id] == 13)
					#Consejo de facultad
						estatusI = EstatusInforme.where(informe_id: @informe_id, actual: 1).take
						if(estatusI.estatus_id != 4)
						@bool_enviado = 1
						end
					end	
				end
			end
		end	
	end

	def mas_observaciones2
		@boolobsb = 0
		@informe_id = params[:informe_id].to_i
		@resultado_id = params[:resultado_id].to_i
		ia = InformeActividad.where(informe_id: @informe_id, resultado_id: @resultado_id).take 

		@observaciones = ObservacionActividadInforme.where(informe_actividad_id: ia.id)

		@observaciones.each do |obs|
			
			if(obs.observaciones != "")
			@boolobs = 1
			end
		end
			
		@observaciones.each do |obs|

			rev =  Revision.find(obs.revision_id)
		
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
		 @bool_enviado = 0
		if (session[:entidad_id] >= 7 && session[:entidad_id] <= 12)
		#Usuario comision
			estatusI = EstatusInforme.where(informe_id: @informe_id, actual: 1).take #Estatus enviado a comision de investigacioni
			if(estatusI.estatus_id != 3)
			@bool_enviado = 1
			end

		else
			if (session[:entidad_id] >= 14 && session[:entidad_id] <= 17)
			#Consejo tecnico
				estatusI = EstatusInforme.where(informe_id: @informe_id, actual: 1).take
				if(estatusI.estatus_id != 2)
				@bool_enviado = 1
				end
			else
				if (session[:entidad_id] >= 1 && session[:entidad_id] <= 6)
				#Consejo de escuela
					estatusI = EstatusInforme.where(informe_id: @informe_id, actual: 1).take 
					if(estatusI.estatus_id != 8)
					@bool_enviado = 1 #Estatus enviado a consejo escuela
					
					end
				else
					if (session[:entidad_id] == 13)
					#Consejo de facultad
						estatusI = EstatusInforme.where(informe_id: @informe_id, actual: 1).take
						if(estatusI.estatus_id != 4)
						@bool_enviado = 1
						end
					end	
				end
			end
		end
		
	end


	def ver_respaldos
		if session[:usuario_id] && session[:entidad] 
		  @plan = Planformacion.where(id: session[:plan_id]).take
		  adec = Adecuacion.where(planformacion_id: session[:plan_id]).take
		  @documents = []
		  if !session[:informe_id].blank?
		    @documents = Respaldo.where(adecuacion_id: adec.id, informe_id: session[:informe_id]).all
		  else
		    @documents = Respaldo.where(adecuacion_id: session[:adecuacion_id], informe_id: nil).all
		  end
		else
		  redirect_to controller:"forminst", action: "index"
		end
	end

	def show
		puts params[:adecuacion_id]
		puts params[:version]

		if params[:informe_id].blank?
			@document = Respaldo.where(adecuacion_id: params[:adecuacion_id], informe_id: nil, version: params[:version].to_i, filename: params[:namefile]).take
			puts "no informe"
		else
			@document = Respaldo.where(adecuacion_id: params[:adecuacion_id], informe_id: params[:informe_id],version: params[:version].to_i, filename: params[:namefile]).take
			puts "informe"
		end
	    send_data(@document.file_contents,
	              type: @document.content_type,
	              filename: @document.filename)
  	end

	def guardar_observaciones2
 		if session[:usuario_id] && session[:entidad]== true
 			@semestre = params[:semestre].to_i
 			@vista_adecuacion = @semestre + 2
		    @adecuacion= Adecuacion.find(session[:adecuacion_id])
		    @estatus= EstatusAdecuacion.where(adecuacion_id: @adecuacion.id).take
		    @cant_doc= params[:cant_docencia].to_i
		    @cant_inv= params[:cant_investigacion].to_i
		    @cant_for= params[:cant_formacion].to_i
		    @cant_ext= params[:cant_extension].to_i
		    @cant_obli= params[:cant_obligatoria].to_i
		    @cant_otr= params[:cant_otra].to_i
		



			revision= Revision.where(usuario_id: session[:usuario_id], adecuacion_id: @adecuacion.id, estatus_id: @estatus.estatus_id, informe_id: nil).take 


			puts  session[:usuario_id]
			puts  @adecuacion.id
			puts  @estatus.estatus_id
	     

	        if(revision == nil || revision =="")

		        revision = Revision.new
		        revision.informe_id = nil
	    	    revision.usuario_id = session[:usuario_id]
	    	    revision.adecuacion_id = @adecuacion.id
	    	    revision.estatus_id = @estatus.estatus_id
	        	revision.fecha =  Time.now
	        	revision.save
			else
				revision.fecha =  Time.now
	        	revision.save

        	end 


		 	#Comienza actividades de docencia
		      	j=0
		      	i=:doc.to_s+j.to_s
		      	@act = params[i].to_i
		      	while j <  @cant_doc
		      		aa= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: params[:semestre].to_i, actividad_id: @act).take

		      		observacion =:observacion.to_s+@act.to_s
		        
		      			oa= ObservacionActividadAdecuacion.where(adecuacionactividad_id: aa, revision_id: revision.id).take

		          		if(oa == nil || oa =="")
				          	oa = ObservacionActividadAdecuacion.new
				          	oa.adecuacionactividad_id = aa.id
				          	oa.revision_id =  revision.id
				          	oa.observaciones = params[observacion]
				          	oa.actual = 1
				          	oa.save
				        else
				       		oa.observaciones = params[observacion]
				       		oa.save
				       	end
		        	  j= j+1
			        i=:doc.to_s+j.to_s
			        @act= params[i].to_i
			    end

		   	#Comienza actividades de investigacion
		      	j=0
		      	i=:inv.to_s+j.to_s
		      	@act = params[i].to_i
		      	k=:result.to_s+j.to_s
		      	@result= params[k].to_i
		      	while j <  @cant_inv
		        	
		        	aa= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: params[:semestre].to_i, actividad_id: @act).take

		      		observacion =:observacion.to_s+@act.to_s
		        
		      			oa= ObservacionActividadAdecuacion.where(adecuacionactividad_id: aa, revision_id: revision.id).take

		          		if(oa == nil || oa =="")
				          	oa = ObservacionActividadAdecuacion.new
				          	oa.adecuacionactividad_id = aa.id
				          	oa.revision_id =  revision.id
				          	oa.observaciones = params[observacion]
				          	oa.actual = 1
				          	oa.save
				        else
				       		oa.observaciones = params[observacion]
				       		oa.save
				       	end
			        j=j+1
			        i=:inv.to_s+j.to_s
			        @act= params[i].to_i
		      	end

		    #Comienza actividades de formación
		      	j=0
		      	i=:for.to_s+j.to_s
		      	@act = params[i].to_i
		      	while j <  @cant_for
		        	aa= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: params[:semestre].to_i, actividad_id: @act).take

		      		observacion =:observacion.to_s+@act.to_s
		        
		      			oa= ObservacionActividadAdecuacion.where(adecuacionactividad_id: aa, revision_id: revision.id).take

		          		if(oa == nil || oa =="")
				          	oa = ObservacionActividadAdecuacion.new
				          	oa.adecuacionactividad_id = aa.id
				          	oa.revision_id =  revision.id
				          	oa.observaciones = params[observacion]
				          	oa.actual = 1
				          	oa.save
				        else
				       		oa.observaciones = params[observacion]
				       		oa.save
				       	end
			  
		        	j= j+1
		        	i=:for.to_s+j.to_s
		        	@act= params[i].to_i
		      	end

	
		    #Comienzan actividades de extensión


		      	j=0
		      	i=:ext.to_s+j.to_s
		      	@act = params[i].to_i
		      	while j <  @cant_ext
		        	aa= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: params[:semestre].to_i, actividad_id: @act).take

		      		observacion =:observacion.to_s+@act.to_s

		      			oa= ObservacionActividadAdecuacion.where(adecuacionactividad_id: aa, revision_id: revision.id).take

		          		if(oa == nil || oa =="")
				          	oa = ObservacionActividadAdecuacion.new
				          	oa.adecuacionactividad_id = aa.id
				          	oa.revision_id =  revision.id
				          	oa.observaciones = params[observacion]
				          	oa.actual = 1
				          	oa.save
				        else
				       		oa.observaciones = params[observacion]
				       		oa.save
				       	end
		        	
			        j= j+1
			        i=:ext.to_s+j.to_s
			        @act= params[i].to_i
			    end


			#Comienzan Otras actividades
		      	j=0
		      	i=:otr.to_s+j.to_s
		      	@act = params[i].to_i
		  

		      	while j <  @cant_otr
		        	aa= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: params[:semestre].to_i, actividad_id: @act).take

		      		observacion =:observacion.to_s+@act.to_s
		        
		      			oa= ObservacionActividadAdecuacion.where(adecuacionactividad_id: aa, revision_id: revision.id).take

		          		if(oa == nil || oa =="")
				          	oa = ObservacionActividadAdecuacion.new
				          	oa.adecuacionactividad_id = aa.id
				          	oa.revision_id =  revision.id
				          	oa.observaciones = params[observacion]
				          	oa.actual = 1
				          	oa.save
				        else
				       		oa.observaciones = params[observacion]
				       		oa.save
				       	end
		        	
			        j= j+1
			        i=:otr.to_s+j.to_s
			        @act= params[i].to_i
			    end

			#Comienza actividades obligatorias
		      	j=0
		      	i=:obli.to_s+j.to_s
		      	@act = params[i].to_i
		      	while j <  @cant_obli
		      		aa= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: params[:semestre].to_i, actividad_id: @act).take

		      		observacion =:observacion.to_s+@act.to_s
		        
		      			oa= ObservacionActividadAdecuacion.where(adecuacionactividad_id: aa, revision_id: revision.id).take

		          		if(oa == nil || oa =="")
				          	oa = ObservacionActividadAdecuacion.new
				          	oa.adecuacionactividad_id = aa.id
				          	oa.revision_id =  revision.id
				          	oa.observaciones = params[observacion]
				          	oa.actual = 1
				          	oa.save
				        else
				       		oa.observaciones = params[observacion]
				       		oa.save
				       	end
		        	  j= j+1
			        i=:obli.to_s+j.to_s
			        @act= params[i].to_i
			    end

	      

	      	flash[:success]="Se han creado y/o modificado las observaciones satisfactoriamente"

	      	if(@semestre == 1)
	      			redirect_to controller:"inicioentidad", action: "detalles_adecuacion3"
	      	end
	      	if(@semestre == 2)
	      			redirect_to controller:"inicioentidad", action: "detalles_adecuacion4"
	      	end
	      	if(@semestre == 3)
	      			redirect_to controller:"inicioentidad", action: "detalles_adecuacion5"
	      	end
	      	if(@semestre == 4)
	      			redirect_to controller:"inicioentidad", action: "detalles_adecuacion6"
	      	end
	      	if(@semestre == 5)
	      			redirect_to controller:"inicioentidad", action: "detalles_adecuacion7"
	      	end
	      
 		end
 	end

 	def mas_observaciones3 #mas obs de actividades del informe
 		@boolobs = 0
 		@adecuacion= Adecuacion.find(session[:adecuacion_id])
 		@semestre = params[:semestre].to_i
 		@actividad_id = params[:actividad_id].to_i
		
		aa= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: @semestre, actividad_id: @actividad_id).take
		
		@observaciones= ObservacionActividadAdecuacion.where(adecuacionactividad_id: aa.id)

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
		@bool_enviado = 0
			if (session[:entidad_id] >= 7 && session[:entidad_id] <= 12)
			#Usuario comision
				estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take #Estatus enviado a comision de investigacioni
				if(estatusI.estatus_id != 3)
				@bool_enviado = 1
				end

			else
				if (session[:entidad_id] >= 14 && session[:entidad_id] <= 17)
				#Consejo tecnico
					estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
					if(estatusI.estatus_id != 2)
					@bool_enviado = 1
					end
				else
					if (session[:entidad_id] >= 1 && session[:entidad_id] <= 6)
					#Consejo de escuela
						estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take 
						if(estatusI.estatus_id != 8)
						@bool_enviado = 1 #Estatus enviado a consejo escuela
						
						end
					else
						if (session[:entidad_id] == 13)
						#Consejo de facultad
							estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
							if(estatusI.estatus_id != 4)
							@bool_enviado = 1
							end
						end	
					end
				end
			end
	end

	def cambiar_estatusI
		@informe_id = params[:informe_id].to_i
		rechazar = params[:rechazar].to_i
		informeAct = Informe.where(id: @informe_id).take
		session[:plan_id] = informeAct.planformacion_id
		adec = Adecuacion.where(planformacion_id: informeAct.planformacion_id).take
		session[:adecuacion_id] = adec.id
		if (session[:entidad_id] >= 7 && session[:entidad_id] <= 12)
			@document = Respaldo.where(adecuacion_id: session[:adecuacion_id], informe_id: @informe_id, actual: 1).take
			@document.estatus = "Enviado a Consejo de Escuela"
			@document.save
			cambio_act = EstatusInforme.where(informe_id: @informe_id, actual: 1).take
	      	cambio_act.actual = 0
	      	cambio_act.save
			cambio_est = EstatusInforme.new 
			cambio_est.informe_id = @informe_id
			cambio_est.fecha = Time.now 
			cambio_est.estatus_id = 8
			cambio_est.actual = 1
			cambio_est.save
			plan = Planformacion.find(session[:plan_id])
			cambio_est.fecha = Time.now 
			notific = Notificacion.new
			notific.instructor_id = plan.instructor_id
			notific.tutor_id = informeAct.tutor_id
			notific.adecuacion_id = session[:adecuacion_id]
			notific.informe_id = @informe_id
			notific.actual = 1
			person = Persona.where(usuario_id: plan.instructor_id).take
			notificacionfecha = Date.current.to_s 
			notific.mensaje = "[" + notificacionfecha + "] El " + session[:nombre_informe] + " de " + person.nombres.to_s.split.map(&:capitalize).join(' ') + " " + person.apellidos.to_s.split.map(&:capitalize).join(' ') + " ha sido aprobado por Comisión de Investigación y fue enviada a Consejo de Escuela."
			notific.save
			notific2 = Notificacion.new
			notific2.instructor_id = plan.instructor_id
			notific2.tutor_id = informeAct.tutor_id
			notific2.adecuacion_id = session[:adecuacion_id]
			notific2.informe_id = @informe_id
			notific2.actual = 2
			notific2.mensaje = "[" + notificacionfecha + "] El " + session[:nombre_informe] + " ha sido aprobado por Comisión de Investigación y fue enviada a Consejo de Escuela."
			notific2.save
			notific3 = Notificacion.new
			notific3.instructor_id = plan.instructor_id
			notific3.tutor_id = informeAct.tutor_id
			notific3.adecuacion_id = session[:adecuacion_id]
			notific3.informe_id = @informe_id
			notific3.actual = 4   #Consejo de Escuela
			notific3.mensaje = "[" + notificacionfecha + "] Ha recibido un nuevo Informe: ' " + session[:nombre_informe]+ " ' de " + person.nombres.to_s.split.map(&:capitalize).join(' ') + " " + person.apellidos.to_s.split.map(&:capitalize).join(' ') + ", favor aprobar y enviar a la siguiente entidad."
			notific3.save
	          user =Usuarioentidad.where(entidad_id: session[:entidad_id]).take
	          if(user.escuela_id == 1)
	            uentidad = Usuarioentidad.where(escuela_id: user.escuela_id, entidad_id: 1).take
	          else
	            if(user.escuela_id == 2)
	              uentidad = Usuarioentidad.where(escuela_id: user.escuela_id, entidad_id: 2).take
	            else
	              if(user.escuela_id == 3)
	                uentidad = Usuarioentidad.where(escuela_id: user.escuela_id, entidad_id: 3).take
	              else
	                if(user.escuela_id == 4)
	                uentidad = Usuarioentidad.where(escuela_id: user.escuela_id, entidad_id: 4).take
	                else
	                  if(user.escuela_id == 9)
	                    uentidad = Usuarioentidad.where(escuela_id: user.escuela_id, entidad_id: 5).take
	                  else
	                    if(user.escuela_id == 10)
	                      uentidad = Usuarioentidad.where(escuela_id: user.escuela_id, entidad_id: 6).take
	                    end
	                  end
	                end
	              end
	            end  
	          end
	          remitente3 = Usuario.where(id: informeAct.tutor_id).take
		      ActionCorreo.envio_informe(remitente3, notific.mensaje,2).deliver
		      remitente2 = Usuario.where(id: plan.instructor_id).take
		      ActionCorreo.envio_informe(remitente2, notific2.mensaje,1).deliver
		      remitente = Usuario.where(id: uentidad.usuario_id).take
		      ActionCorreo.envio_informe(remitente, notific3.mensaje,0).deliver
	          flash[:success]="El informe se ha envíado a consejo de escuela"


		else
			if (session[:entidad_id] >= 14 && session[:entidad_id] <= 17)
			#Consejo tecnico

			else
				if (session[:entidad_id] >= 1 && session[:entidad_id] <= 6)
				#Consejo de escuela
					@document = Respaldo.where(adecuacion_id: session[:adecuacion_id], informe_id: @informe_id, actual: 1).take
					@document.estatus = "Enviado a Consejo de Facultad"
					@document.save
					cambio_act = EstatusInforme.where(informe_id: @informe_id, actual: 1).take
			      	cambio_act.actual = 0
			      	cambio_act.save
					cambio_est = EstatusInforme.new 
					cambio_est.informe_id = @informe_id
					cambio_est.fecha = Time.now 
					cambio_est.estatus_id = 4
					cambio_est.actual = 1
					cambio_est.save
					plan = Planformacion.find(session[:plan_id])
					cambio_est.fecha = Time.now 
					notific = Notificacion.new
					notific.instructor_id = plan.instructor_id
					notific.tutor_id = informeAct.tutor_id
					notific.adecuacion_id = session[:adecuacion_id]
					notific.informe_id = @informe_id
					notific.actual = 1
					person = Persona.where(usuario_id: plan.instructor_id).take
					notificacionfecha = Date.current.to_s 
					notific.mensaje = "[" + notificacionfecha + "] El " + session[:nombre_informe] + " de " + person.nombres.to_s.split.map(&:capitalize).join(' ') + " " + person.apellidos.to_s.split.map(&:capitalize).join(' ') + " ha sido aprobado por Consejo de Escuela y fue enviada a Consejo de Facultad."
					notific.save
					notific2 = Notificacion.new
					notific2.instructor_id = plan.instructor_id
					notific2.tutor_id = informeAct.tutor_id
					notific2.adecuacion_id = session[:adecuacion_id]
					notific2.informe_id = @informe_id
					notific2.actual = 2
					notific2.mensaje = "[" + notificacionfecha + "] El " + session[:nombre_informe] + " ha sido aprobado por Consejo de Escuela y fue enviada a Consejo de Facultad."
					notific2.save
					notific3 = Notificacion.new
					notific3.instructor_id = plan.instructor_id
					notific3.tutor_id = informeAct.tutor_id
					notific3.adecuacion_id = session[:adecuacion_id]
					notific3.informe_id = @informe_id
					notific3.actual = 5   #Consejo de Facultad
					notific3.mensaje = "[" + notificacionfecha + "] Ha recibido un nuevo Informe: ' " + session[:nombre_informe]+ " ' de " + person.nombres.to_s.split.map(&:capitalize).join(' ') + " " + person.apellidos.to_s.split.map(&:capitalize).join(' ') + ", revisar."
					notific3.save

					uentidad = Usuarioentidad.where(entidad_id: 13).take
					remitente3 = Usuario.where(id: informeAct.tutor_id).take
					ActionCorreo.envio_informe(remitente3, notific.mensaje,2).deliver
					remitente2 = Usuario.where(id: plan.instructor_id).take
					ActionCorreo.envio_informe(remitente2, notific2.mensaje,1).deliver
					remitente = Usuario.where(id: uentidad.usuario_id).take
					ActionCorreo.envio_informe(remitente, notific3.mensaje,0).deliver
					flash[:success]="El informe se ha envíado a consejo de facultad"
				else
					if (session[:entidad_id] == 13)

						bool_observaciones= 0
						acts_informe = InformeActividad.where(informe_id: @informe_id)
						
						if (rechazar == 2)
							bool_observaciones = 1
						end
						#Consejo de facultad
						cambio_act = EstatusInforme.where(informe_id: @informe_id, actual: 1).take
				      	cambio_act.actual = 0
				      	cambio_act.save

				      	cambio_est = EstatusInforme.new 
						cambio_est.informe_id = @informe_id
						cambio_est.fecha = Time.now
						if(rechazar == 1)
							cambio_est.estatus_id = 9
						else 
							if bool_observaciones == 1 
								cambio_est.estatus_id = 5
							else
								cambio_est.estatus_id = 1
							end
						end
						cambio_est.actual = 1
						cambio_est.save

						
						inf = Informe.where(id: @informe_id).take
						cambio_est.fecha = Time.now 
						plan = Planformacion.find(session[:plan_id])
						if(rechazar == 1)
							@document = Respaldo.where(adecuacion_id: session[:adecuacion_id], informe_id: @informe_id, actual: 1).take
							@document.estatus = "Rechazado por Consejo de Facultad"
							@document.actual = 0
							@document.save
							flash[:info]="El informe ha sido rechazado por consejo de facultad"
							notific = Notificacion.new
							notific.instructor_id = plan.instructor_id
							notific.tutor_id = informeAct.tutor_id
							notific.adecuacion_id = session[:adecuacion_id]
							notific.informe_id = @informe_id
							notific.actual = 1
							person = Persona.where(usuario_id: plan.instructor_id).take
							notificacionfecha = Date.current.to_s 
							notific.mensaje = "[" + notificacionfecha + "] El " + session[:nombre_informe] + " de " + person.nombres.to_s.split.map(&:capitalize).join(' ') + " " + person.apellidos.to_s.split.map(&:capitalize).join(' ') + " ha sido rechazado por Consejo de Facultad."
							notific.save
							notific2 = Notificacion.new
							notific2.instructor_id = plan.instructor_id
							notific2.tutor_id = informeAct.tutor_id
							notific2.adecuacion_id = session[:adecuacion_id]
							notific2.informe_id = @informe_id
							notific2.actual = 2
							notific2.mensaje = "[" + notificacionfecha + "] El " + session[:nombre_informe] + " ha sido rechazado por Consejo de Facultad."
							notific2.save
							remitente3 = Usuario.where(id: informeAct.tutor_id).take
							ActionCorreo.envio_informe(remitente3, notific.mensaje,2).deliver
							remitente2 = Usuario.where(id: plan.instructor_id).take
							ActionCorreo.envio_informe(remitente2, notific2.mensaje,1).deliver
						else
							if bool_observaciones == 1 
								@document = Respaldo.where(adecuacion_id: session[:adecuacion_id], informe_id: @informe_id, actual: 1).take
								@document.estatus = "Aprobado por Consejo de Facultad con Observaciones"
								@document.actual = 0
								@document.save	
								flash[:info]="El informe ha sido aprobado con observaciones por consejo de facultad"
								notific = Notificacion.new
								notific.instructor_id = plan.instructor_id
								notific.tutor_id = informeAct.tutor_id
								notific.adecuacion_id = session[:adecuacion_id]
								notific.informe_id = @informe_id
								notific.actual = 1
								person = Persona.where(usuario_id: plan.instructor_id).take
								notificacionfecha = Date.current.to_s 
								notific.mensaje = "[" + notificacionfecha + "] El " + session[:nombre_informe] + " de " + person.nombres.to_s.split.map(&:capitalize).join(' ') + " " + person.apellidos.to_s.split.map(&:capitalize).join(' ') + " ha sido aprobado con observaciones por Consejo de Facultad."
								notific.save
								notific2 = Notificacion.new
								notific2.instructor_id = plan.instructor_id
								notific2.tutor_id = informeAct.tutor_id
								notific2.adecuacion_id = session[:adecuacion_id]
								notific2.informe_id = @informe_id
								notific2.actual = 2
								notific2.mensaje = "[" + notificacionfecha + "] El " + session[:nombre_informe] + " ha sido aprobado con observaciones por Consejo de Facultad."
								notific2.save
								remitente3 = Usuario.where(id: informeAct.tutor_id).take
								ActionCorreo.envio_informe(remitente3, notific.mensaje,2).deliver
								remitente2 = Usuario.where(id: plan.instructor_id).take
								ActionCorreo.envio_informe(remitente2, notific2.mensaje,1).deliver
							else
								@document = Respaldo.where(adecuacion_id: session[:adecuacion_id], informe_id: @informe_id, actual: 1).take
								@document.estatus = "Aprobado por Consejo de Facultad"
								@document.actual = 0
								@document.save
								flash[:info]="El informe ha sido aprobado por consejo de facultad"
								notific = Notificacion.new
								notific.instructor_id = plan.instructor_id
								notific.tutor_id = informeAct.tutor_id
								notific.adecuacion_id = session[:adecuacion_id]
								notific.informe_id = @informe_id
								notific.actual = 1
								person = Persona.where(usuario_id: plan.instructor_id).take
								notificacionfecha = Date.current.to_s 
								notific.mensaje = "[" + notificacionfecha + "] ¡Felicitaciones! El " + session[:nombre_informe] + " de " + person.nombres.to_s.split.map(&:capitalize).join(' ') + " " + person.apellidos.to_s.split.map(&:capitalize).join(' ') + " ha sido aprobado por Consejo de Facultad."
								notific.save
								notific2 = Notificacion.new
								notific2.instructor_id = plan.instructor_id
								notific2.tutor_id = informeAct.tutor_id
								notific2.adecuacion_id = session[:adecuacion_id]
								notific2.informe_id = @informe_id
								notific2.actual = 2
								notific2.mensaje = "[" + notificacionfecha + "] ¡Felicitaciones! El " + session[:nombre_informe] + " ha sido aprobado por Consejo de Facultad."
								notific2.save	
								remitente3 = Usuario.where(id: informeAct.tutor_id).take
								ActionCorreo.envio_informe(remitente3, notific.mensaje,2).deliver
								remitente2 = Usuario.where(id: plan.instructor_id).take
								ActionCorreo.envio_informe(remitente2, notific2.mensaje,1).deliver
							end
						end
					end	
				end
			end
		end
		redirect_to controller:"inicioentidad", action: "listar_informes"
	end 
	
	def vista_previa
		session[:informe_id]=nil
		@fechaActual = Date.current.to_s
		@plan= Planformacion.find(session[:plan_id])
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
		@obligatoria= 'obligatoria'
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

		@actividades5obli= []
		@actividades5= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: 5).all
		@actividades5.each do |actade| 
			@act= Actividad.find(actade.actividad_id)
			tipo= @act.tipo_actividad_id
			if tipo==7
				puts "soy otro tipo de actividad"
				puts @act.actividad
				@actividades5obli.push(@act)
			end
		end

		@bool_enviado = 0
		if (session[:entidad_id] >= 7 && session[:entidad_id] <= 12)
		#Usuario comision
			estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take #Estatus enviado a comision de investigacioni
			if(estatusI.estatus_id != 3)
			@bool_enviado = 1
			end

		else
			if (session[:entidad_id] >= 14 && session[:entidad_id] <= 17)
			#Consejo tecnico
				estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
				if(estatusI.estatus_id != 2)
				@bool_enviado = 1
				end
			else
				if (session[:entidad_id] >= 1 && session[:entidad_id] <= 6)
				#Consejo de escuela
					estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take 
					if(estatusI.estatus_id != 8)
					@bool_enviado = 1 #Estatus enviado a consejo escuela
					
					end
				else
					if (session[:entidad_id] == 13)
					#Consejo de facultad
						estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
						if(estatusI.estatus_id != 4)
						@bool_enviado = 1
						end
					end	
				end
			end
		end
	end

	def cambiar_estatusA

	@adecuacion_id = params[:adecuacion_id].to_i
	rechazar = params[:rechazar].to_i

	if (session[:entidad_id] >= 7 && session[:entidad_id] <= 12)
			#Usuario comision
				cambio_act = EstatusAdecuacion.where(adecuacion_id: @adecuacion_id, actual: 1).take
	      		cambio_act.actual = 0
	      		cambio_act.save
				cambio_est = EstatusAdecuacion.new 
				cambio_est.adecuacion_id = @adecuacion_id
				cambio_est.fecha = Time.now 
				cambio_est.estatus_id = 8
				cambio_est.actual = 1
				cambio_est.save
				cambio_est.fecha = Time.now 
				adac = AdecuacionActividad.where(adecuacion_id: @adecuacion_id).all
				adac.each do |adaa|
					oa = ObservacionActividadAdecuacion.where(adecuacionactividad_id: adaa.id, actual: 1).all
					oa.each do |oaa|
						oaa.fecha = Time.now 
						oaa.actual = 0
						oaa.save
					end
				end

				plan= Planformacion.find(session[:plan_id])
				notific = Notificacion.new
				@document = Respaldo.where(adecuacion_id: session[:adecuacion_id], informe_id: nil, actual: 1).take
				@document.estatus = "Enviado a Consejo de Escuela"
				@document.save

		        notific.instructor_id = plan.instructor_id
		        notific.tutor_id = plan.tutor_id
		        notific.adecuacion_id = session[:adecuacion_id]
		        notific.informe_id = nil
		        notific.actual = 1
		        puts "JAJAJA"
		        person = Persona.where(usuario_id: plan.instructor_id).take
		        notificacionfecha = Date.current.to_s 
	        	notific.mensaje = "[" + notificacionfecha + "] La adecuación de "+ person.nombres.to_s.split.map(&:capitalize).join(' ') + " " + person.apellidos.to_s.split.map(&:capitalize).join(' ') + " ha sido aprobada por Comisión de Investigación y fue enviada a Consejo de Escuela."
	        	notific.save
	        	notific2 = Notificacion.new
		        notific2.instructor_id = plan.instructor_id
		        notific2.tutor_id = plan.tutor_id
		        notific2.adecuacion_id = session[:adecuacion_id]
		        notific2.informe_id = nil
		        notific2.actual = 2
	        	notific2.mensaje = "[" + notificacionfecha + "] Su adecuación ha sido aprobada por Comisión de Investigación y fue enviada a Consejo de Escuela"
	        	notific2.save
	        	notific3 = Notificacion.new
		        notific3.instructor_id = plan.instructor_id
		        notific3.tutor_id = plan.tutor_id
		        notific3.adecuacion_id = session[:adecuacion_id]
		        notific3.informe_id = nil
		        notific3.actual = 4		#Consejo de Escuela
	        	notific3.mensaje = "[" + notificacionfecha + "] Se ha recibido una nueva Adecuación: "+ person.nombres.to_s.split.map(&:capitalize).join(' ') + " " + person.apellidos.to_s.split.map(&:capitalize).join(' ') + ", favor aprobar y enviar a la siguiente entidad."
	        	notific3.save

				 user =Usuarioentidad.where(entidad_id: session[:entidad_id]).take
		          if(user.escuela_id == 1)
		            uentidad = Usuarioentidad.where(escuela_id: user.escuela_id, entidad_id: 1).take
		          else
		            if(user.escuela_id == 2)
		              uentidad = Usuarioentidad.where(escuela_id: user.escuela_id, entidad_id: 2).take
		            else
		              if(user.escuela_id == 3)
		                uentidad = Usuarioentidad.where(escuela_id: user.escuela_id, entidad_id: 3).take
		              else
		                if(user.escuela_id == 4)
		                uentidad = Usuarioentidad.where(escuela_id: user.escuela_id, entidad_id: 4).take
		                else
		                  if(user.escuela_id == 9)
		                    uentidad = Usuarioentidad.where(escuela_id: user.escuela_id, entidad_id: 5).take
		                  else
		                    if(user.escuela_id == 10)
		                      uentidad = Usuarioentidad.where(escuela_id: user.escuela_id, entidad_id: 6).take
		                    end
		                  end
		                end
		              end
		            end  
		          end
					remitente3 = Usuario.where(id: plan.tutor_id).take
					ActionCorreo.envio_adecuacion(remitente3, notific.mensaje,2).deliver
					remitente2 = Usuario.where(id: plan.instructor_id).take
					ActionCorreo.envio_adecuacion(remitente2, notific2.mensaje,1).deliver
					remitente = Usuario.where(id: uentidad.usuario_id).take
					ActionCorreo.envio_adecuacion(remitente, notific3.mensaje,0).deliver

				flash[:success]="La adecuación se ha envíado a consejo de escuela"

		
			else
				if (session[:entidad_id] >= 14 && session[:entidad_id] <= 17)
				#Consejo tecnico
		
				else
					if (session[:entidad_id] >= 1 && session[:entidad_id] <= 6)
					#Consejo de escuela
						adac = AdecuacionActividad.where(adecuacion_id: @adecuacion_id).all
						adac.each do |adaa|
							oa = ObservacionActividadAdecuacion.where(adecuacionactividad_id: adaa.id, actual: 1).all
							oa.each do |oaa|
								oaa.fecha = Time.now 
								oaa.actual = 0
								oaa.save
							end
						end
						@document = Respaldo.where(adecuacion_id: session[:adecuacion_id], informe_id: nil, actual: 1).take
						@document.estatus = "Enviado a Consejo de Facultad"
						@document.save
						cambio_act = EstatusAdecuacion.where(adecuacion_id: @adecuacion_id, actual: 1).take
	      				cambio_act.actual = 0
	      				cambio_act.save
						cambio_est = EstatusAdecuacion.new 
						cambio_est.adecuacion_id = @adecuacion_id
						cambio_est.fecha = Time.now 
						cambio_est.estatus_id = 4
						cambio_est.actual = 1
						cambio_est.save
						cambio_est.fecha = Time.now 
						plan= Planformacion.find(session[:plan_id])
						notific = Notificacion.new
				        notific.instructor_id = plan.instructor_id
				        notific.tutor_id = plan.tutor_id
				        notific.adecuacion_id = session[:adecuacion_id]
				        notific.informe_id = nil
				        notific.actual = 1
				        person = Persona.where(usuario_id: plan.instructor_id).take
				        notificacionfecha = Date.current.to_s 
			        	notific.mensaje = "[" + notificacionfecha + "] La adecuación de "+ person.nombres.to_s.split.map(&:capitalize).join(' ') + " " + person.apellidos.to_s.split.map(&:capitalize).join(' ') + " ha sido aprobada por Consejo de Escuela y fue enviada a Consejo de Facultad."
			        	notific.save
			        	notific2 = Notificacion.new
				        notific2.instructor_id = plan.instructor_id
				        notific2.tutor_id = plan.tutor_id
				        notific2.adecuacion_id = session[:adecuacion_id]
				        notific2.informe_id = nil
				        notific2.actual = 2
			        	notific2.mensaje = "[" + notificacionfecha + "] Su adecuación ha sido aprobada por Consejo de Escuela y fue enviada a Consejo de Facultad"
			        	notific2.save
			        	notific3 = Notificacion.new
				        notific3.instructor_id = plan.instructor_id
				        notific3.tutor_id = plan.tutor_id
				        notific3.adecuacion_id = session[:adecuacion_id]
				        notific3.informe_id = nil
				        notific3.actual = 5		#Consejo de Escuela
			        	notific3.mensaje = "[" + notificacionfecha + "] Se ha recibido una nueva Adecuación: "+ person.nombres.to_s.split.map(&:capitalize).join(' ') + " " + person.apellidos.to_s.split.map(&:capitalize).join(' ') + ", Revisar."
			        	notific3.save
			       		uentidad = Usuarioentidad.where(entidad_id: 13).take
						remitente3 = Usuario.where(id: plan.tutor_id).take
						ActionCorreo.envio_adecuacion(remitente3, notific.mensaje,2).deliver
						remitente2 = Usuario.where(id: plan.instructor_id).take
						ActionCorreo.envio_adecuacion(remitente2, notific2.mensaje,1).deliver
						remitente = Usuario.where(id: uentidad.usuario_id).take
						ActionCorreo.envio_adecuacion(remitente, notific3.mensaje,0).deliver

						flash[:success]="La adecuación se ha envíado a consejo de facultad"
					else
						if (session[:entidad_id] == 13)

							bool_observaciones= 0
							acts_adecuacion = AdecuacionActividad.where(adecuacion_id: @adecuacion_id)

							if (rechazar == 2)
								bool_observaciones = 1
							end
							#Consejo de facultad
							cambio_act = EstatusAdecuacion.where(adecuacion_id: @adecuacion_id, actual: 1).take
		      				cambio_act.actual = 0
		      				cambio_act.save	
							cambio_est = EstatusAdecuacion.new 
							cambio_est.adecuacion_id = @adecuacion_id
							cambio_est.fecha = Time.now 
							if(rechazar == 1)
								cambio_est.estatus_id = 9
							else 
								if bool_observaciones == 1 
									cambio_est.estatus_id = 5
								else
									cambio_est.estatus_id = 1
								end
							end
							cambio_est.actual = 1
							cambio_est.save
							
							adec = Adecuacion.where(id: @adecuacion_id).take
							plan = Planformacion.where(id: adec.planformacion_id).take
							if(rechazar == 1)
								@document = Respaldo.where(adecuacion_id: session[:adecuacion_id], informe_id: nil, actual: 1).take
								@document.estatus = "Rechazado por Consejo de Facultad"
								@document.actual = 0
								@document.save
								flash[:info]="La adecuación ha sido rechazada por consejo de facultad"
								notific = Notificacion.new
						        notific.instructor_id = plan.instructor_id
						        notific.tutor_id = plan.tutor_id
						        notific.adecuacion_id = session[:adecuacion_id]
						        notific.informe_id = nil
						        notific.actual = 1
						        person = Persona.where(usuario_id: plan.instructor_id).take
						        notificacionfecha = Date.current.to_s 
								notific.mensaje = "[" + notificacionfecha + "] La adecuación de " + person.nombres.to_s.split.map(&:capitalize).join(' ') + " " + person.apellidos.to_s.split.map(&:capitalize).join(' ') + " ha sido rechazada por Consejo de Facultad."
								notific.save
								notific2 = Notificacion.new
						        notific2.instructor_id = plan.instructor_id
						        notific2.tutor_id = plan.tutor_id
						        notific2.adecuacion_id = session[:adecuacion_id]
						        notific2.informe_id = nil
						        notific2.actual = 2
								notific2.mensaje = "[" + notificacionfecha + "] Su adecuación ha sido rechazada por Consejo de Facultad."
								notific2.save
								remitente3 = Usuario.where(id: adec.tutor_id).take	
								ActionCorreo.envio_adecuacion(remitente3, notific.mensaje,2).deliver		##CORREO AL TUTOR
								remitente2 = Usuario.where(id: plan.instructor_id).take
								ActionCorreo.envio_adecuacion(remitente2, notific2.mensaje,1).deliver		##CORREO AL INSTRUCTOR
							else
								if bool_observaciones == 1 
									@document = Respaldo.where(adecuacion_id: session[:adecuacion_id], informe_id: nil, actual: 1).take
									@document.estatus = "Aprobado por Consejo de Facultad con Observaciones"
									@document.actual = 0
									@document.save
									flash[:info]="La adecuación ha sido aprobada con observaciones por consejo de facultad"
									notific = Notificacion.new
							        notific.instructor_id = plan.instructor_id
							        notific.tutor_id = plan.tutor_id
							        notific.adecuacion_id = session[:adecuacion_id]
							        notific.informe_id = nil
							        notific.actual = 1
							        person = Persona.where(usuario_id: plan.instructor_id).take
							        notificacionfecha = Date.current.to_s 
									notific.mensaje = "[" + notificacionfecha + "] La adecuación de " + person.nombres.to_s.split.map(&:capitalize).join(' ') + " " + person.apellidos.to_s.split.map(&:capitalize).join(' ') + " ha sido aprobada con observaciones por Consejo de Facultad."
									notific.save
									notific2 = Notificacion.new
							        notific2.instructor_id = plan.instructor_id
							        notific2.tutor_id = plan.tutor_id
							        notific2.adecuacion_id = session[:adecuacion_id]
							        notific2.informe_id = nil
							        notific2.actual = 2
									notific2.mensaje = "[" + notificacionfecha + "] Su adecuación ha sido aprobado con observaciones por Consejo de Facultad."
									notific2.save
									remitente3 = Usuario.where(id: adec.tutor_id).take	
									ActionCorreo.envio_adecuacion(remitente3, notific.mensaje,2).deliver		##CORREO AL TUTOR
									remitente2 = Usuario.where(id: plan.instructor_id).take
									ActionCorreo.envio_adecuacion(remitente2, notific2.mensaje,1).deliver		##CORREO AL INSTRUCTOR
								else
									@document = Respaldo.where(adecuacion_id: session[:adecuacion_id], informe_id: nil, actual: 1).take
									@document.estatus = "Aprobado por Consejo de Facultad"
									@document.actual = 0
									@document.save
									flash[:info]="El informe ha sido aprobado por consejo de facultad"
									notific = Notificacion.new
							        notific.instructor_id = plan.instructor_id
							        notific.tutor_id = plan.tutor_id
							        notific.adecuacion_id = session[:adecuacion_id]
							        notific.informe_id = nil
							        notific.actual = 1
							        person = Persona.where(usuario_id: plan.instructor_id).take
							        notificacionfecha = Date.current.to_s 
									notific.mensaje = "[" + notificacionfecha + "] ¡Felicitaciones! La adecuación de " + person.nombres.to_s.split.map(&:capitalize).join(' ') + " " + person.apellidos.to_s.split.map(&:capitalize).join(' ') + " ha sido aprobada por Consejo de Facultad."
									notific.save
									notific2 = Notificacion.new
							        notific2.instructor_id = plan.instructor_id
							        notific2.tutor_id = plan.tutor_id
							        notific2.adecuacion_id = session[:adecuacion_id]
							        notific2.informe_id = nil
							        notific2.actual = 2
									notific2.mensaje = "[" + notificacionfecha + "] ¡Felicitaciones! Su adecuación ha sido aprobada por Consejo de Facultad."
									notific2.save	
									remitente3 = Usuario.where(id: adec.tutor_id).take	
									ActionCorreo.envio_adecuacion(remitente3, notific.mensaje,2).deliver		##CORREO AL TUTOR
									remitente2 = Usuario.where(id: plan.instructor_id).take
									ActionCorreo.envio_adecuacion(remitente2, notific2.mensaje,1).deliver		##CORREO AL INSTRUCTOR
								end
							end
							adac = AdecuacionActividad.where(adecuacion_id: @adecuacion_id).all
							adac.each do |adaa|
								oa = ObservacionActividadAdecuacion.where(adecuacionactividad_id: adaa.id, actual: 1).all
								oa.each do |oaa|
									oaa.fecha = Time.now 
									oaa.actual = 0
									oaa.save
								end
							end
						end	
					end
				end
			end
	 redirect_to controller:"inicioentidad", action: "listar_adecuaciones"
	end 

	def borrar_notificaciones #mas obs de actividades del informe
		if session[:usuario_id] && session[:entidad]= true
			@noti= params[:noti]
			puts @noti
    		notaeliminar = Notificacion.where(id: @noti ).take
    		if notaeliminar.blank?
    			flash[:danger] = "Ha ocurrido un error al eliminar (notificacion no existente)"
    		else
    			notaeliminar.destroy
    		end
			redirect_to controller:"inicioentidad", action: "index"
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

end