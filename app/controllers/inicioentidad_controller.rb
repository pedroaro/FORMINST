class InicioentidadController < ApplicationController
	layout 'ly_inicio_entidad'

	def index
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

	def listar_adecuaciones
		if session[:usuario_id]
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

	def ver_detalles_adecuacion
		if session[:usuario_id]
			@nombre = session[:nombre_usuario]
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
			@plan= Planformacion.find(@adecuacion.planformacion_id)
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
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def detalles_adecuacion2
		if session[:usuario_id]
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
		else
			redirect_to controller:"forminst", action: "index"
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

	def detalles_adecuacion3
		if session[:usuario_id]
			@semestre = 1
			@iddoc= 'id_docencia'
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
		if session[:usuario_id]
			@semestre = 2
			@iddoc= 'id_docencia'
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
		if session[:usuario_id]
			@semestre = 3
			@iddoc= 'id_docencia'
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
		if session[:usuario_id]
			@semestre = 4
			@iddoc= 'id_docencia'
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

	

	def listar_informes
	    if session[:usuario_id]
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
	    if session[:usuario_id]
	      	@nombre = session[:nombre_usuario]
	      	if params[:informe_id]!=nil
	        	session[:informe_id]= params[:informe_id]
	      	end
	      	@informe= Informe.find(session[:informe_id])
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

	      	if @informe.numero == 1
	        	@nombre_informe= "PRIMER INFORME "
	        	session[:numero_informe]=1
	      	else
	        	if @informe.numero == 2
	         	 @nombre_informe= "SEGUNDO INFORME "
	          	session[:numero_informe]=2
	        	else
	          	if @informe.numero == 3
	            	@nombre_informe= "TERCER INFORME "
	            	session[:numero_informe]=3
	          	else                                                        
	            	@nombre_informe= "CUARTO INFORME "
	            	session[:numero_informe]=4
	          	end
	        	end
	      	end

	      	if @informe.tipo_id == 1
	        	@nombre_informe= @nombre_informe+"SEMESTRAL"
	      	else
	        	if @informe.tipo_id == 2
	          		@nombre_informe= @nombre_informe+"ANUAL"
	        	else
	          		@nombre_informe= @nombre_informe+"FINAL"
	        	end
	      	end

	      	@estatus= EstatusInforme.where(informe_id: @informe.id, actual: 1).take
	      	@status= TipoEstatus.find(@estatus.estatus_id)
	      	@userentidad=Usuarioentidad.where(entidad_id: session[:entidad_id]).take
			@escuela= Escuela.find(@userentidad.escuela_id)
	      	session[:nombre_informe] = @nombre_informe
	      	session[:status_informe] = @status.concepto

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
    	@j= 0
    	@k=0
    	@actividadesa= InformeActividad.where(informe_id: @informe.id).all
    	@actividadesadoc= []
    	@actividadesainv= []
    	@actividadesaext= []
    	@actividadesafor= []
    	@actividadesaotr= []
    	@resultados= []
    	@actividadese= []
    	@observaciont= []
    	@revision= Revision.where(informe_id: @informe.id, usuario_id: session[:usuario_id], adecuacion_id: @adecuacion.id, estatus_id: @est.estatus_id).take
    	@actividadesa.each do |actade| 
	      	if actade.actividad_id == nil #Es el caso que es un resultado no contemplado en el plan de formacion o un avancwe de postgrado
	        	@res= Resultado.find(actade.resultado_id)
	        	@resultados.push(@res)
	        	@actividadese.push("")

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
		        if actade.resultado_id
		          	@res= Resultado.find(actade.resultado_id)
		          	@resultados.push(@res)
		        else
		          	@resultados.push(nil)
		        end
		        @ae= ActividadEjecutada.where(informe_actividad_id: actade.id).take
		        if @ae==nil || @ae== ""
		        	
		        	@actividadese.push("")
		        else
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

 	def guardar_observaciones
 		if session[:usuario_id]
 
 			@informe = Informe.find(session[:informe_id])
 			@adecuacion = Adecuacion.where(planformacion_id: @informe.planformacion_id).take
 			@estatus = EstatusInforme.where(informe_id: @informe.id, actual: 1).take
		    @cant_doc = params[:cant_docencia].to_i
		    @cant_inv = params[:cant_investigacion].to_i
		    @cant_for = params[:cant_formacion].to_i
		    @cant_ext = params[:cant_extension].to_i
		    @cant_otr = params[:cant_otra].to_i
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


			#Comienzan Otras actividades
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

	      	flash[:mensaje]="Se han creado y/o modificado las observaciones satisfactoriamente"
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



	def guardar_observaciones2
 		if session[:usuario_id]
 			@semestre = params[:semestre].to_i
 			@vista_adecuacion = @semestre + 2
		    @adecuacion= Adecuacion.find(session[:adecuacion_id])
		    @estatus= EstatusAdecuacion.where(adecuacion_id: @adecuacion.id).take
		    @cant_doc= params[:cant_docencia].to_i
		    @cant_inv= params[:cant_investigacion].to_i
		    @cant_for= params[:cant_formacion].to_i
		    @cant_ext= params[:cant_extension].to_i
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
				          	oa.save
				        else
				       		oa.observaciones = params[observacion]
				       		oa.save
				       	end
		        	
			        j= j+1
			        i=:otr.to_s+j.to_s
			        @act= params[i].to_i
			    end

	      

	      	flash[:mensaje]="Se han creado y/o modificado las observaciones satisfactoriamente"

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
	      			redirect_to controller:"inicioentidad", action: "detalles_adecuacion5"
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

	if (session[:entidad_id] >= 7 && session[:entidad_id] <= 12)
			#Usuario comision

				cambio_act = EstatusInforme.where(informe_id: @informe_id, actual: 1).take
		      	cambio_act.actual = 0
		      	cambio_act.save
				cambio_est = EstatusInforme.new 
				cambio_est.informe_id = @informe_id
				cambio_est.fecha = Time.now 
				cambio_est.estatus_id = 8
				cambio_est.actual = 1
				cambio_est.save
			 
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
		          remitente = Usuario.where(id: uentidad.usuario_id).take
		          email = remitente.user + "@ciens.ucv.ve"
		          ActionCorreo.envio_informe(email).deliver
		          flash[:mensaje]="El informe se ha envíado a consejo de escuela"

		
			else
				if (session[:entidad_id] >= 14 && session[:entidad_id] <= 17)
				#Consejo tecnico
		
				else
					if (session[:entidad_id] >= 1 && session[:entidad_id] <= 6)
					#Consejo de escuela
						cambio_act = EstatusInforme.where(informe_id: @informe_id, actual: 1).take
				      	cambio_act.actual = 0
				      	cambio_act.save
						cambio_est = EstatusInforme.new 
						cambio_est.informe_id = @informe_id
						cambio_est.fecha = Time.now 
						cambio_est.estatus_id = 4
						cambio_est.actual = 1
						cambio_est.save

						uentidad = Usuarioentidad.where(entidad_id: 13).take
			            remitente = Usuario.where(id: uentidad.usuario_id).take
			            email= remitente.user + "@ciens.ucv.ve"
			            ActionCorreo.envio_informe(email).deliver

						flash[:mensaje]="El informe se ha envíado a consejo de facultad"
					else
						if (session[:entidad_id] == 13)

							bool_observaciones= 0
							acts_informe = InformeActividad.where(informe_id: @informe_id)
							
							acts_informe.each do |act_informe|
								obsvs_act = ObservacionActividadInforme.where(informe_actividad_id: act_informe.id)

								obsvs_act.each do |obsv_act|
									if obsv_act.observaciones != ''
										bool_observaciones= 1
									end
								end
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
			            	remitente = Usuario.where(id: inf.tutor_id).take
			            	email= remitente.user + "@ciens.ucv.ve"
			            	ActionCorreo.envio_informe(email).deliver

							if(rechazar == 1)
								flash[:mensaje]="El informe ha sido rechazado por consejo de facultad"
							else
								if bool_observaciones == 1 
									flash[:mensaje]="El informe ha sido aprobado con observaciones por consejo de facultad"
								else
										flash[:mensaje]="El informe ha sido aprobado por consejo de facultad"	
								end
							end
						end	
					end
				end
			end
	 redirect_to controller:"inicioentidad", action: "listar_informes"
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
		          remitente = Usuario.where(id: uentidad.usuario_id).take
		          email = remitente.user + "@ciens.ucv.ve"
		          ActionCorreo.envio_adecuacion(email).deliver

				flash[:mensaje]="La adecuación se ha envíado a consejo de escuela"

		
			else
				if (session[:entidad_id] >= 14 && session[:entidad_id] <= 17)
				#Consejo tecnico
		
				else
					if (session[:entidad_id] >= 1 && session[:entidad_id] <= 6)
					#Consejo de escuela

						cambio_act = EstatusAdecuacion.where(adecuacion_id: @adecuacion_id, actual: 1).take
	      				cambio_act.actual = 0
	      				cambio_act.save
						cambio_est = EstatusAdecuacion.new 
						cambio_est.adecuacion_id = @adecuacion_id
						cambio_est.fecha = Time.now 
						cambio_est.estatus_id = 4
						cambio_est.actual = 1
						cambio_est.save

						uentidad = Usuarioentidad.where(entidad_id: 13).take
			            remitente = Usuario.where(id: uentidad.usuario_id).take
			            email= remitente.user + "@ciens.ucv.ve"
			            ActionCorreo.envio_adecuacion(email).deliver

						flash[:mensaje]="La adecuación se ha envíado a consejo de facultad"
					else
						if (session[:entidad_id] == 13)

							bool_observaciones= 0
								acts_adecuacion = AdecuacionActividad.where(adecuacion_id: @adecuacion_id)
								
								acts_adecuacion.each do |act_adecuacion|
									obsvs_act = ObservacionActividadAdecuacion.where(adecuacionactividad_id: act_adecuacion.id)

									obsvs_act.each do |obsv_act|
										if obsv_act.observaciones != ''
											bool_observaciones= 1
										end
									end
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
			            	remitente = Usuario.where(id: adec.tutor_id).take
			            	email= remitente.user + "@ciens.ucv.ve"
			            	ActionCorreo.envio_adecuacion(email).deliver

							if(rechazar == 1)
								flash[:mensaje]="La adecuación ha sido rechazada por consejo de facultad"
							else
								if bool_observaciones == 1 
									flash[:mensaje]="La adecuación ha sido aprobada con observaciones por consejo de facultad"
								else
									flash[:mensaje]="La adecuación ha sido aprobada por consejo de facultad"	
								end
							end
						end	
					end
				end
			end
	 redirect_to controller:"inicioentidad", action: "listar_adecuaciones"
	end 


end