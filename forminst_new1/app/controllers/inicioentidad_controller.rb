class InicioentidadController < ApplicationController
	layout 'ly_inicio_entidad'

	def index
		if session[:usuario_id] && session[:entidad] == true
			session[:adecuacion_id] = nil
			session[:plan_id] = nil
			session[:instructorName] = nil
			session[:informe_id]=nil
			@usuarioAux=Usuario.find(session[:usuario_id])
			@cjpTipo=@usuarioAux.tipo
			@nombre = session[:nombre_usuario]
			@usu=Usuarioentidad.where(usuario_id: @usuarioAux.id).take
			@entidad_escuela_id= @usu.escuela_id
			@notificaciones1= []
			puts @usu.departamento_id
			puts "aaaaaaaaaaaaaaaaaaaaaaaaaaa"
			puts @entidad_escuela_id
			if (session[:entidad_id] >= 7 && session[:entidad_id] <= 12)#Caso de Comision de Investigación
				if(@entidad_escuela_id == 1)
					@notificaciones = Notificacion.where(actual: 3, departamento_id: @usu.departamento_id).all
				else
					@notificaciones = Notificacion.where(actual: 3).all
				end
		    	@notificaciones.each do |notificaciones|
			    	@tutor_escuela = Usuarioentidad.where(usuario_id: notificaciones.tutor_id).take
			    	if (@tutor_escuela.escuela_id == @entidad_escuela_id) #Caso de notificaciones del Comision de investigación 
			        	@notificaciones1.push(notificaciones)
			        end
		    	end
		    elsif (session[:entidad_id] >= 1 && session[:entidad_id] <= 6)#Caso Consejo de Escuela
		    	@notificaciones = Notificacion.where(actual: 4).all
		    	@notificaciones.each do |notificaciones|
			    	@tutor_escuela = Usuarioentidad.where(usuario_id: notificaciones.tutor_id).take
			    	if (@tutor_escuela.escuela_id == @entidad_escuela_id) #Caso de notificaciones del Comision de investigación 
			        	@notificaciones1.push(notificaciones)
			        end
		    	end
		    elsif (session[:entidad_id] == 13)							#Caso Consejo de Facultad
		    	@notificaciones1 = Notificacion.where(actual: 5).all
		    end			
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	#Cerrar Sesión
	def logout	
		reset_session
		redirect_to controller: "forminst", action: "index"
	end

	#Modulo para activar a los instructores inhabilitados
	def reactivacion
		if session[:usuario_id]
			enti = Usuarioentidad.where(usuario_id: session[:usuario_id]).take
		end
		#Solamente el consejo de facultad tiene la posibilidad de reactivar instructores
		if session[:usuario_id] && session[:entidad] == true && enti.entidad_id == 13
			session[:adecuacion_id] = nil
			session[:plan_id] = nil
			session[:instructorName] = nil
			session[:informe_id]=nil
			@cjpTipo=Usuario.find(session[:usuario_id]).tipo
			@nombre = session[:nombre_usuario]
			@usu=Usuarioentidad.where(entidad_id: session[:entidad_id]).take
			@entidad_escuela_id= @usu.escuela_id
			@usuarios = Usuario.where(activo: 0).all
			@instructores = []
			cpcontador = 0
			@instructores[cpcontador] = Array.new(2) { |i|  }
			@instructores[cpcontador][0] =  "Seleccione el instructor"
			@instructores[cpcontador][1] = 0
			cpcontador = cpcontador + 1

			@usuarios.each do |usuari|		#Arreglo con los usuarios inahibilitados
				cppersona = Persona.find_by usuario_id: usuari.id
				@instructores[cpcontador] = Array.new(2) { |i|  }
				@instructores[cpcontador][0] = cppersona.nombres.to_s.split.map(&:capitalize).join(' ') + " " + cppersona.apellidos.to_s.split.map(&:capitalize).join(' ')
				@instructores[cpcontador][1] = usuari.id
				cpcontador = cpcontador + 1
			end

			i = 1
			j = 1
			nombre = "hola"
			cpid = 1

			#Ordena los nombres por orden alfabetico (Ordenamiento Burbuja)
			while i < cpcontador  do
				nombre = @instructores[i][0]
				cpid = @instructores[i][1]
				j = i + 1
				while j < cpcontador  do

					if @instructores[j][0] < nombre
						@instructores[i][0] = @instructores[j][0]
						@instructores[i][1] = @instructores[j][1]
						@instructores[j][0] = nombre
						@instructores[j][1] = cpid
						nombre = @instructores[i][0]
						cpid = @instructores[i][1]
					end

					j +=1
				end
				i +=1
			end

		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	#Guardar la reactivacion de Usuarios
	def reactivacion_guardar
		if session[:usuario_id]	
			if params[:Instructor].to_s != "0"
				usuari = Usuario.where(id: params[:Instructor]).take
				if !usuari.blank?
					usuari.activo = 1
					usuari.save
					pers = Persona.where(usuario_id: usuari.id).take
					nombres = pers.nombres.to_s.split.map(&:capitalize).join(' ') + " " + pers.apellidos.to_s.split.map(&:capitalize).join(' ')
					flash[:success]= "Se ha habilitado a " + nombres + " de manera exitosa"
				else
					flash[:danger]= "Error al seleccionar usuario, puede no existir en la Base de Datos"
				end
			else
				flash[:info]= "Debe seleccionar un instructor primero"
			end
			redirect_to :back
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	#Lista las adecuaciones, independientemente si fueron ya enviadas a entidades mayores

	def listar_adecuaciones
		if session[:usuario_id] && session[:entidad]== true
			session[:informe_id]=nil
			@cjpTipo=Usuario.find(session[:usuario_id]).tipo
			session[:adecuacion_id]=nil
				@nombre = session[:nombre_usuario]
				@usu=Usuarioentidad.where(usuario_id: session[:usuario_id]).take
				@entidad_escuela_id= @usu.escuela_id
				@entidad_departamento= @usu.departamento_id
				@adecuaciones = []
				@status = []
				@nombre_tutor = []
				@nombre_instructor = []
			if (session[:entidad_id] >= 7 && session[:entidad_id] <= 12)
			#Usuario comision
				@status_inv = EstatusAdecuacion.where(actual: 1,  estatus_id: [3,2,8,4,1,5,9,12,13,14,18]) #Estatus enviado a comision de investigacion
	
			else
				if (session[:entidad_id] >= 14 && session[:entidad_id] <= 17)
				#Consejo tecnico
					@status_inv = EstatusAdecuacion.where(actual: 1, estatus_id: [2,8,4,1,5,9,12,18,14]) #Estatus enviado a consejo tecnico
				else
					if (session[:entidad_id] >= 1 && session[:entidad_id] <= 6)
					#Consejo de escuela
						@status_inv = EstatusAdecuacion.where(actual: 1, estatus_id: [8,4,1,5,9,18,14]) #Estatus enviado a consejo escuela
					else
						if (session[:entidad_id] == 13)
						#Consejo de facultad
							@status_inv = EstatusAdecuacion.where(actual: 1, estatus_id: [4,1,5,9,14]) #Estatus enviado a consejo de facultad
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
					elsif(si.estatus_id==2)
						@st = "ENVIADO A CONSEJO TÉCNICO"
					elsif(si.estatus_id==3)
						@st = "ENVIADO A COMISION DE INVESTIGACIÓN"
					elsif(si.estatus_id==4)
						@st = "ENVIADO A CONSEJO DE FACULTAD"
					elsif(si.estatus_id==5)
						@st = "APROBADO CON OBSERVACIONES POR CONSEJO DE FACULTAD"
					elsif(si.estatus_id==8)
						@st = "ENVIADO A CONSEJO DE ESCUELA"
					elsif(si.estatus_id==9)
						@st = "RECHAZADO POR CONSEJO DE FACULTAD"
			        elsif(si.estatus_id==12)
			            @st = "ENVIADO A CONSEJO TÉCNICO SIN REVISIÓN"
			        elsif(si.estatus_id==13)
			            @st = "ENVIADO A COMISIÓN DE INVESTIGACIÓN SIN REVISIÓN"
			        elsif(si.estatus_id==14)
			            @st = "ENVIADO A CONSEJO DE FACULTAD SIN REVISIÓN"
			        elsif(si.estatus_id==18)
			            @st = "ENVIADO A CONSEJO DE ESCUELA SIN REVISIÓN"
					end
					@status.push(@st)
					@nombre_tutor.push(Persona.where(usuario_id: @pf.tutor_id).take.nombres)
					@nombre_instructor.push(Persona.where(usuario_id: @pf.instructor_id).take.nombres)
				else
					#Para que salgan las adecuaciones correspondientes a la escuela y al departamento
					@tutor_escuela = Usuarioentidad.where(usuario_id: @adec.tutor_id).take
					if @tutor_escuela.escuela_id == @entidad_escuela_id && (@tutor_escuela.departamento_id == @entidad_departamento || @entidad_departamento == nil)
						
						@adecuacion = true
						@adecuaciones.push(@adec)
						if(si.estatus_id==1)
							@st = "APROBADO POR CONSEJO DE FACULTAD"
						elsif(si.estatus_id==2)
							@st = "ENVIADO A CONSEJO TÉCNICO"
						elsif(si.estatus_id==3)
							@st = "ENVIADO A COMISION DE INVESTIGACIÓN"
						elsif(si.estatus_id==4)
							@st = "ENVIADO A CONSEJO DE FACULTAD"
						elsif(si.estatus_id==5)
							@st = "APROBADO CON OBSERVACIONES POR CONSEJO DE FACULTAD"
						elsif(si.estatus_id==8)
							@st = "ENVIADO A CONSEJO DE ESCUELA"
						elsif(si.estatus_id==9)
							@st = "RECHAZADO POR CONSEJO DE FACULTAD"
				        elsif(si.estatus_id==12)
				            @st = "ENVIADO A CONSEJO TÉCNICO SIN REVISIÓN"
				        elsif(si.estatus_id==13)
				            @st = "ENVIADO A COMISIÓN DE INVESTIGACIÓN SIN REVISIÓN"
				        elsif(si.estatus_id==14)
				            @st = "ENVIADO A CONSEJO DE FACULTAD SIN REVISIÓN"
				        elsif(si.estatus_id==18)
				            @st = "ENVIADO A CONSEJO DE ESCUELA SIN REVISIÓN"
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

#Modulo para poder visualizar los soportes adjuntados por el tutor
def ver_soporte
    @plan = Planformacion.where(id: session[:plan_id]).take
    @adecuacion = Adecuacion.where(planformacion_id: session[:plan_id]).take
    @documents = []
	@cjpTipo=Usuario.find(session[:usuario_id]).tipo
    if !session[:informe_id].blank?
    	$actividad = params[:actividad_id].to_i
    	adec = Adecuacion.where(planformacion_id: session[:plan_id]).take
    	session[:adecuacion_id] = adec.id
      	@documents = Document.where(adecuacion_id: session[:adecuacion_id], informe_id: session[:informe_id], actividad_id: $actividad).all
		@bool_enviado = 0
		if (session[:entidad_id] >= 7 && session[:entidad_id] <= 12)
		#Usuario comision
			estatusI = EstatusInforme.where(informe_id: session[:informe_id], actual: 1).take #Estatus enviado a comision de investigacioni
			if(estatusI.estatus_id != 3 && estatusI.estatus_id != 13)
				@bool_enviado = 1
			end
		elsif (session[:entidad_id] >= 14 && session[:entidad_id] <= 17)
			#Consejo tecnico
			estatusI = EstatusInforme.where(informe_id: session[:informe_id], actual: 1).take
			if(estatusI.estatus_id != 2 && estatusI.estatus_id != 12)
				@bool_enviado = 1
			end
		elsif (session[:entidad_id] >= 1 && session[:entidad_id] <= 6)
			#Consejo de escuela
			estatusI = EstatusInforme.where(informe_id: session[:informe_id], actual: 1).take 
			if(estatusI.estatus_id != 8 && estatusI.estatus_id != 18)
				@bool_enviado = 1 #Estatus enviado a consejo escuela
			end
		elsif (session[:entidad_id] == 13)
			#Consejo de facultad
			estatusI = EstatusInforme.where(informe_id: session[:informe_id], actual: 1).take
			if(estatusI.estatus_id != 4 && estatusI.estatus_id != 14)
				@bool_enviado = 1
			end
		end		    
	else
		@documents = Document.where(adecuacion_id: session[:adecuacion_id], informe_id: nil).all
		@bool_enviado = 0
		if (session[:entidad_id] >= 7 && session[:entidad_id] <= 12)
		#Usuario comision
			estatusI = EstatusAdecuacion.where(adecuacion_id: session[:adecuacion_id], actual: 1).take #Estatus enviado a comision de investigacioni
			if(estatusI.estatus_id != 3 && estatusI.estatus_id != 13)
				@bool_enviado = 1
			end
		elsif (session[:entidad_id] >= 14 && session[:entidad_id] <= 17)
		#Consejo tecnico
			estatusI = EstatusAdecuacion.where(adecuacion_id: session[:adecuacion_id], actual: 1).take
			if(estatusI.estatus_id != 2 && estatusI.estatus_id != 12)
				@bool_enviado = 1
			end
		elsif (session[:entidad_id] >= 1 && session[:entidad_id] <= 6)
		#Consejo de escuela
			estatusI = EstatusAdecuacion.where(adecuacion_id: session[:adecuacion_id], actual: 1).take 
			if(estatusI.estatus_id != 8 && estatusI.estatus_id != 18)
				@bool_enviado = 1 #Estatus enviado a consejo escuela
			end
		elsif (session[:entidad_id] == 13)
		#Consejo de facultad
			estatusI = EstatusAdecuacion.where(adecuacion_id: session[:adecuacion_id], actual: 1).take
			if(estatusI.estatus_id != 4 && estatusI.estatus_id != 14)
				@bool_enviado = 1
			end
		end	
    end
end

	#Modulo para ver la primera pestaña de las adecuaciones
	def ver_detalles_adecuacion
		if session[:usuario_id] && session[:entidad] == true
			if (!session[:adecuacion_id].blank? || !params[:adecuacion_id].blank?)
				@cjpTipo=Usuario.find(session[:usuario_id]).tipo
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
					if(estatusI.estatus_id != 3 && estatusI.estatus_id != 13)
						@bool_enviado = 1
					end
				elsif (session[:entidad_id] >= 14 && session[:entidad_id] <= 17)
					#Consejo tecnico
					estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
					if(estatusI.estatus_id != 2 && estatusI.estatus_id != 12)
						@bool_enviado = 1
					end
				elsif (session[:entidad_id] >= 1 && session[:entidad_id] <= 6)
					#Consejo de escuela
					estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take 
					if(estatusI.estatus_id != 8 && estatusI.estatus_id != 18)
						@bool_enviado = 1 #Estatus enviado a consejo escuela
					end
				elsif (session[:entidad_id] == 13)
				#Consejo de facultad
					estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
					if(estatusI.estatus_id != 4 && estatusI.estatus_id != 14)
						@bool_enviado = 1
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
					if(estatusI.estatus_id != 3 && estatusI.estatus_id != 13)
						@bool_enviado = 1
					end
				elsif (session[:entidad_id] >= 14 && session[:entidad_id] <= 17)
					#Consejo tecnico
					estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
					if(estatusI.estatus_id != 2 && estatusI.estatus_id != 12)
						@bool_enviado = 1
					end
				elsif (session[:entidad_id] >= 1 && session[:entidad_id] <= 6)
					#Consejo de escuela
					estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take 
					if(estatusI.estatus_id != 8 && estatusI.estatus_id != 18)
						@bool_enviado = 1 #Estatus enviado a consejo escuela
					end
				elsif (session[:entidad_id] == 13)
					#Consejo de facultad
					estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
					if(estatusI.estatus_id != 4 && estatusI.estatus_id != 14)
						@bool_enviado = 1
					end
				end
			else
				flash[:info]="Seleccione una adecuación primero"
				redirect_to controller:"inicioentidad", action: "listar_adecuaciones"
			end

		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	#Modulo para ver la segunda pestaña de las adecuaciones
	def detalles_adecuacion2

		if session[:usuario_id] && session[:entidad]
			if session[:adecuacion_id]
				@cjpTipo=Usuario.find(session[:usuario_id]).tipo
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
				@nombre = session[:nombre_usuario]
				@semestre="0"
				@actividadesadoc= []
				@actividadesainv= []
				@actividadesaext= []
				@actividadesafor= []
				@actividadesaotr= []
				@observaciont= []
				@observacionesExtras= []
				@iddoc= 'id_docencia'
				@docencia='docencia'
				@investigacion= 'investigacion'
				@formacion= 'formacion'
				@extension= 'extension'
				@otra= 'otra' 
				@j=0
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
				@est= EstatusAdecuacion.where(adecuacion_id: @adecuacion.id).take
				@revision= Revision.where(usuario_id: session[:usuario_id], adecuacion_id: @adecuacion.id, estatus_id: @est.estatus_id, informe_id: nil).take
				actividades = AdecuacionActividad.where(adecuacion_id: session[:adecuacion_id], semestre: 0)
				if !actividades.blank?
					actividades.each do |actividadAde|
						actividad = Actividad.find(actividadAde.actividad_id)
						if actividad.tipo_actividad_id == 9
							@presentacion = actividad.actividad
							@presentacionId = actividad.id
							if(@revision!=nil && @revision != "")
								@cpObs= ObservacionActividadAdecuacion.where(adecuacionactividad_id: @presentacionId).where.not(revision_id: @revision.id).all
							else
								@cpObs= ObservacionActividadAdecuacion.where(adecuacionactividad_id: @presentacionId).all
							end
						    if @cpObs.blank?
						    	@observacionesExtras[@presentacionId]="no"
						    else
						    	@observacionesExtras[@presentacionId]="si"
						    end
						elsif actividad.tipo_actividad_id == 8
							@descripcion = actividad.actividad
							@descripcionId = actividad.id
							if(@revision!=nil && @revision != "")
								@cpObs= ObservacionActividadAdecuacion.where(adecuacionactividad_id: @descripcionId).where.not(revision_id: @revision.id).all
							else
								@cpObs= ObservacionActividadAdecuacion.where(adecuacionactividad_id: @descripcionId).all
							end
						    if @cpObs.blank?
						    	@observacionesExtras[@descripcionId]="no"
						    else
						    	@observacionesExtras[@descripcionId]="si"
						    end
						end
					end
				end

				@est= EstatusAdecuacion.where(adecuacion_id: @adecuacion.id).take
				@revision= Revision.where(usuario_id: session[:usuario_id], adecuacion_id: @adecuacion.id, estatus_id: @est.estatus_id, informe_id: nil).take
				@actividadesa= AdecuacionActividad.where(adecuacion_id: session[:adecuacion_id], semestre: 0).all
				@actividadesa.each do |actade| 

					@act= Actividad.find(actade.actividad_id)
					tipo= @act.tipo_actividad_id

					if(@revision!=nil && @revision != "")
				
						@obs= ObservacionActividadAdecuacion.where(adecuacionactividad_id: actade.id, revision_id: @revision.id).take
			       
				        if @obs==nil
							@observaciont[@act.id] = ""
				        else
							@observaciont[@act.id] = @obs.observaciones
				        end

				        @cpObs= ObservacionActividadAdecuacion.where(adecuacionactividad_id: actade.id).where.not(revision_id: @revision.id).all
					    if @cpObs.blank?
					    	@observacionesExtras[@act.id]="no"
					    else
					    	@observacionesExtras[@act.id]="si"
					    end
					else 
						@cpObs= ObservacionActividadAdecuacion.where(adecuacionactividad_id: actade.id).all

					    if @cpObs.blank?
					    	@observacionesExtras[@act.id]="no"
					    else

							cpBool = 0
							@cpObs.each do |probar|
								if !probar.observaciones.blank?
									cpBool = 1
								end
							end

					    	if cpBool == 0
					    		@observacionesExtras[@act.id]="no"
					    	else
					    		@observacionesExtras[@act.id]="si"
					    	end
					    end
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
					end
				end

				if params[:editar] == 'no' 
					session[:editar]= false
				end
				@est= EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
				
				@bool_enviado = 0
				if (session[:entidad_id] >= 7 && session[:entidad_id] <= 12)
				#Usuario comision
					estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take #Estatus enviado a comision de investigacioni
					if(estatusI.estatus_id != 3 && estatusI.estatus_id != 13)
						@bool_enviado = 1
					end
				elsif (session[:entidad_id] >= 14 && session[:entidad_id] <= 17)
				#Consejo tecnico
					estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
					if(estatusI.estatus_id != 2 && estatusI.estatus_id != 12)
						@bool_enviado = 1
					end
				elsif (session[:entidad_id] >= 1 && session[:entidad_id] <= 6)
					#Consejo de escuela
					estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take 
					if(estatusI.estatus_id != 8 && estatusI.estatus_id != 18)
						@bool_enviado = 1 #Estatus enviado a consejo escuela
					end
				elsif (session[:entidad_id] == 13)
					#Consejo de facultad
					estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
					if(estatusI.estatus_id != 4 && estatusI.estatus_id != 14)
						@bool_enviado = 1
					end
				end	

				#Presentacion 
				aa= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: 0, actividad_id: @presentacionId).take
				if !aa.blank?
					cp = ObservacionActividadAdecuacion.where(adecuacionactividad_id: aa.id, actual: 1).take
					if !cp.blank?
						@obsPresentacion = cp.observaciones
					end
				end

				#Descripcion 
				aa= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: 0, actividad_id: @descripcionId).take
				if !aa.blank?
					cp = ObservacionActividadAdecuacion.where(adecuacionactividad_id: aa.id, actual: 1).take
					if !cp.blank?
						@obsDescripcion = cp.observaciones
					end
				end
			else
				flash[:info]="Seleccione una adecuación primero"
				redirect_to controller:"inicioentidad", action: "listar_adecuaciones"
			end
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	#Modulo para ver la tercera pestaña de las adecuaciones
	def detalles_adecuacion3
		if session[:usuario_id] && session[:entidad] == true
			if !session[:adecuacion_id].blank?
				@cjpTipo=Usuario.find(session[:usuario_id]).tipo
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
				@observacionesExtras= []
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
							@observaciont[@act.id] = ""
				        else
							@observaciont[@act.id] = @obs.observaciones
				        end

				        @cpObs= ObservacionActividadAdecuacion.where(adecuacionactividad_id: actade.id).where.not(revision_id: @revision.id).all
					    if @cpObs.blank?
					    	@observacionesExtras[@act.id]="no"
					    else
					    	@observacionesExtras[@act.id]="si"
					    end
					else 
						@cpObs= ObservacionActividadAdecuacion.where(adecuacionactividad_id: actade.id).all

					    if @cpObs.blank?
					    	@observacionesExtras[@act.id]="no"
					    else

							cpBool = 0
							@cpObs.each do |probar|
								if !probar.observaciones.blank?
									cpBool = 1
								end
							end

					    	if cpBool == 0
					    		@observacionesExtras[@act.id]="no"
					    	else
					    		@observacionesExtras[@act.id]="si"
					    	end
					    end
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
					end
				end
				@bool_enviado = 0
				if (session[:entidad_id] >= 7 && session[:entidad_id] <= 12)
				#Usuario comision
					estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take #Estatus enviado a comision de investigacioni
					if(estatusI.estatus_id != 3 && estatusI.estatus_id != 13)
						@bool_enviado = 1
					end
				elsif (session[:entidad_id] >= 14 && session[:entidad_id] <= 17)
					#Consejo tecnico
					estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
					if(estatusI.estatus_id != 2 && estatusI.estatus_id != 12)
						@bool_enviado = 1
					end
				elsif (session[:entidad_id] >= 1 && session[:entidad_id] <= 6)
				#Consejo de escuela
					estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take 
					if(estatusI.estatus_id != 8 && estatusI.estatus_id != 18)
						@bool_enviado = 1 #Estatus enviado a consejo escuela
					end
				elsif (session[:entidad_id] == 13)
				#Consejo de facultad
					estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
					if(estatusI.estatus_id != 4 && estatusI.estatus_id != 14)
						@bool_enviado = 1
					end
				end	
			else
				flash[:info]="Seleccione una adecuación primero"
				redirect_to controller:"inicioentidad", action: "listar_adecuaciones"
			end
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	#Modulo para ver la cuarta pestaña de las adecuaciones
	def detalles_adecuacion4
		if session[:usuario_id] && session[:entidad] == true
			if !session[:adecuacion_id].blank?
				@cjpTipo=Usuario.find(session[:usuario_id]).tipo
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
				@observacionesExtras= []
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
				          	@observaciont[@act.id]=""
				        else
				          	@observaciont[@act.id]=@obs.observaciones
				        end

				        @cpObs= ObservacionActividadAdecuacion.where(adecuacionactividad_id: actade.id).where.not(revision_id: @revision.id).all
					    if @cpObs.blank?
					    	@observacionesExtras[@act.id]="no"
					    else
					    	@observacionesExtras[@act.id]="si"
					    end
					else 
						@cpObs= ObservacionActividadAdecuacion.where(adecuacionactividad_id: actade.id).all

					    if @cpObs.blank?
					    	@observacionesExtras[@act.id]="no"
					    else

							cpBool = 0
							@cpObs.each do |probar|
								if !probar.observaciones.blank?
									cpBool = 1
								end
							end

					    	if cpBool == 0
					    		@observacionesExtras[@act.id]="no"
					    	else
					    		@observacionesExtras[@act.id]="si"
					    	end
					    end
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
					end
				end
				@bool_enviado = 0
				if (session[:entidad_id] >= 7 && session[:entidad_id] <= 12)
				#Usuario comision
					estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take #Estatus enviado a comision de investigacioni
					if(estatusI.estatus_id != 3 && estatusI.estatus_id != 13)
						@bool_enviado = 1
					end
				elsif (session[:entidad_id] >= 14 && session[:entidad_id] <= 17)
					#Consejo tecnico
					estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
					if(estatusI.estatus_id != 2 && estatusI.estatus_id != 12)
						@bool_enviado = 1
					end
				elsif (session[:entidad_id] >= 1 && session[:entidad_id] <= 6)
					#Consejo de escuela
					estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take 
					if(estatusI.estatus_id != 8 && estatusI.estatus_id != 18)
						@bool_enviado = 1 #Estatus enviado a consejo escuela
					end
				elsif (session[:entidad_id] == 13)
					#Consejo de facultad
					estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
					if(estatusI.estatus_id != 4 && estatusI.estatus_id != 14)
						@bool_enviado = 1
					end
				end	
			else
				flash[:info]="Seleccione una adecuación primero"
				redirect_to controller:"inicioentidad", action: "listar_adecuaciones"
			end
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	#Modulo para ver la quinta pestaña de las adecuaciones
	def detalles_adecuacion5
		if session[:usuario_id] && session[:entidad] == true
			if !session[:adecuacion_id].blank?
				@cjpTipo=Usuario.find(session[:usuario_id]).tipo
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
				@observacionesExtras= []
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
				          	@observaciont[@act.id]=""
				        else
				          	@observaciont[@act.id]=@obs.observaciones
				        end

				        @cpObs= ObservacionActividadAdecuacion.where(adecuacionactividad_id: actade.id).where.not(revision_id: @revision.id).all
					    if @cpObs.blank?
					    	@observacionesExtras[@act.id]="no"
					    else
					    	@observacionesExtras[@act.id]="si"
					    end
					else 
						@cpObs= ObservacionActividadAdecuacion.where(adecuacionactividad_id: actade.id).all

					    if @cpObs.blank?
					    	@observacionesExtras[@act.id]="no"
					    else

							cpBool = 0
							@cpObs.each do |probar|
								if !probar.observaciones.blank?
									cpBool = 1
								end
							end

					    	if cpBool == 0
					    		@observacionesExtras[@act.id]="no"
					    	else
					    		@observacionesExtras[@act.id]="si"
					    	end
					    end
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
					end
				end
				@bool_enviado = 0
				if (session[:entidad_id] >= 7 && session[:entidad_id] <= 12)
				#Usuario comision
					estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take #Estatus enviado a comision de investigacioni
					if(estatusI.estatus_id != 3 && estatusI.estatus_id != 13)
						@bool_enviado = 1
					end
				elsif (session[:entidad_id] >= 14 && session[:entidad_id] <= 17)
					#Consejo tecnico
					estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
					if(estatusI.estatus_id != 2 && estatusI.estatus_id != 12)
						@bool_enviado = 1
					end
				elsif (session[:entidad_id] >= 1 && session[:entidad_id] <= 6)
					#Consejo de escuela
					estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take 
					if(estatusI.estatus_id != 8 && estatusI.estatus_id != 18)
						@bool_enviado = 1 #Estatus enviado a consejo escuela
					end
				elsif (session[:entidad_id] == 13)
					#Consejo de facultad
					estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
					if(estatusI.estatus_id != 4 && estatusI.estatus_id != 14)
						@bool_enviado = 1
					end
				end	
			else
				redirect_to controller:"inicioentidad" , action: "listar_adecuaciones"
			end
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def detalles_adecuacion6
		if session[:usuario_id] && session[:entidad] == true
			if !session[:adecuacion_id].blank?
				@cjpTipo=Usuario.find(session[:usuario_id]).tipo
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
				@observacionesExtras= []
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
				          	@observaciont[@act.id]=""
				        else
				          	@observaciont[@act.id]=@obs.observaciones
				        end

				        @cpObs= ObservacionActividadAdecuacion.where(adecuacionactividad_id: actade.id).where.not(revision_id: @revision.id).all
					    if @cpObs.blank?
					    	@observacionesExtras[@act.id]="no"
					    else
					    	@observacionesExtras[@act.id]="si"
					    end
					else 
						@cpObs= ObservacionActividadAdecuacion.where(adecuacionactividad_id: actade.id).all

					    if @cpObs.blank?
					    	@observacionesExtras[@act.id]="no"
					    else

							cpBool = 0
							@cpObs.each do |probar|
								if !probar.observaciones.blank?
									cpBool = 1
								end
							end

					    	if cpBool == 0
					    		@observacionesExtras[@act.id]="no"
					    	else
					    		@observacionesExtras[@act.id]="si"
					    	end
					    end
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
					end
				end
				@bool_enviado = 0
				if (session[:entidad_id] >= 7 && session[:entidad_id] <= 12)
				#Usuario comision
					estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take #Estatus enviado a comision de investigacioni
					if(estatusI.estatus_id != 3 && estatusI.estatus_id != 13)
						@bool_enviado = 1
					end
				elsif (session[:entidad_id] >= 14 && session[:entidad_id] <= 17)
					#Consejo tecnico
					estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
					if(estatusI.estatus_id != 2 && estatusI.estatus_id != 12)
						@bool_enviado = 1
					end
				elsif (session[:entidad_id] >= 1 && session[:entidad_id] <= 6)
					#Consejo de escuela
					estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take 
					if(estatusI.estatus_id != 8 && estatusI.estatus_id != 18)
						@bool_enviado = 1 #Estatus enviado a consejo escuela
					end
				elsif (session[:entidad_id] == 13)
					#Consejo de facultad
					estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
					if(estatusI.estatus_id != 4 && estatusI.estatus_id != 14)
						@bool_enviado = 1
					end
				end
			else
				flash[:info]="Seleccione una adecuación primero"
				redirect_to controller:"inicioentidad", action: "listar_adecuaciones"
			end
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def detalles_adecuacion7
		if session[:usuario_id] && session[:entidad]== true
			if !session[:adecuacion_id].blank?
				@cjpTipo=Usuario.find(session[:usuario_id]).tipo
				@semestre = 5
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
				@observaciont= []
				@observacionesExtras= []
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
				          	@observaciont[@act.id]=""
				        else
				          	@observaciont[@act.id]=@obs.observaciones
				        end

				        @cpObs= ObservacionActividadAdecuacion.where(adecuacionactividad_id: actade.id).where.not(revision_id: @revision.id).all
					    if @cpObs.blank?
					    	@observacionesExtras[@act.id]="no"
					    else
					    	@observacionesExtras[@act.id]="si"
					    end
					else 
						@cpObs= ObservacionActividadAdecuacion.where(adecuacionactividad_id: actade.id).all

					    if @cpObs.blank?
					    	@observacionesExtras[@act.id]="no"
					    else

							cpBool = 0
							@cpObs.each do |probar|
								if !probar.observaciones.blank?
									cpBool = 1
								end
							end

					    	if cpBool == 0
					    		@observacionesExtras[@act.id]="no"
					    	else
					    		@observacionesExtras[@act.id]="si"
					    	end
					    end
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
					end
				end
				@bool_enviado = 0
				if (session[:entidad_id] >= 7 && session[:entidad_id] <= 12)
				#Usuario comision
					estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take #Estatus enviado a comision de investigacioni
					if(estatusI.estatus_id != 3 && estatusI.estatus_id != 13)
						@bool_enviado = 1
					end
				elsif (session[:entidad_id] >= 14 && session[:entidad_id] <= 17)
					#Consejo tecnico
					estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
					if(estatusI.estatus_id != 2 && estatusI.estatus_id != 12)
						@bool_enviado = 1
					end
				elsif (session[:entidad_id] >= 1 && session[:entidad_id] <= 6)
					#Consejo de escuela
					estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take 
					if(estatusI.estatus_id != 8 && estatusI.estatus_id != 18)
						@bool_enviado = 1 #Estatus enviado a consejo escuela
					end
				elsif (session[:entidad_id] == 13)
					#Consejo de facultad
					estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
					if(estatusI.estatus_id != 4 && estatusI.estatus_id != 14)
						@bool_enviado = 1
					end
				end	
			else
				flash[:info]="Seleccione una adecuación primero"
				redirect_to controller:"inicioentidad", action: "listar_adecuaciones"
			end
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

#Modulo para mostrar los informes enviados a comision de investigacion o aprobadas por el mismo
	def listar_informes
	    if session[:usuario_id] && session[:entidad]== true

			@cjpTipo=Usuario.find(session[:usuario_id]).tipo
	    	session[:informe_id]=nil
	    	@nombre = session[:nombre_usuario]
			@usu=Usuarioentidad.where(usuario_id: session[:usuario_id]).take
			@entidad_escuela_id= @usu.escuela_id
			@depto = @usu.departamento_id
			@informes = []
			@tipos= []
			@status = []
			@nombre_tutor = []
			@nombre_instructor = []
			if (session[:entidad_id] >= 7 && session[:entidad_id] <= 12)
			#Usuario comision
				@status_inv = EstatusInforme.where(actual: 1,  estatus_id: [3,2,8,4,1,5,9,13,12,18,14]) #Estatus enviado a comision de investigacion
			elsif (session[:entidad_id] >= 14 && session[:entidad_id] <= 17)
			#Consejo tecnico
				@status_inv = EstatusInforme.where(actual: 1, estatus_id: [2,8,4,1,5,9,12,18,14]) #Estatus enviado a consejo tecnico
			elsif (session[:entidad_id] >= 1 && session[:entidad_id] <= 6)
			#Consejo de escuela
				@status_inv = EstatusInforme.where(actual: 1, estatus_id: [8,4,1,5,9,18,14]) #Estatus enviado a consejo escuela
			elsif (session[:entidad_id] == 13)
			#Consejo de facultad
				@status_inv = EstatusInforme.where(actual: 1, estatus_id: [4,1,5,9,14]) #Estatus enviado a consejo de facultad
				@entidad_escuela_id=nil
			end
			@status_inv.each do |si|
				@inf= Informe.find(si.informe_id)
				@pf = Planformacion.find(@inf.planformacion_id)
				@ppp = Persona.where(usuario_id: @pf.instructor_id).take.nombres
				if (session[:entidad_id] == 13)			#Si es consejo de facultad, listar todos los informes enviados a CF sin importar la escuela
					@informe = true
					@informes.push(@inf)
					if(si.estatus_id==1)
						@st = "APROBADO POR CONSEJO DE FACULTAD"
					elsif(si.estatus_id==2)
						@st = "ENVIADO A CONSEJO TÉCNICO"
					elsif(si.estatus_id==3)
						@st = "ENVIADO A COMISION DE INVESTIGACIÓN"
					elsif(si.estatus_id==4)
						@st = "ENVIADO A CONSEJO DE FACULTAD"
					elsif(si.estatus_id==5)
						@st = "APROBADO CON OBSERVACIONES POR CONSEJO DE FACULTAD"
					elsif(si.estatus_id==6)
                  		@st = "GUARDADO"
					elsif(si.estatus_id==8)
						@st = "ENVIADO A CONSEJO DE ESCUELA"
					elsif(si.estatus_id==9)
						@st = "RECHAZADO POR CONSEJO DE FACULTAD"
			        elsif(si.estatus_id==12)
			            @st = "ENVIADO A CONSEJO TÉCNICO SIN REVISIÓN"
			        elsif(si.estatus_id==13)
			            @st = "ENVIADO A COMISIÓN DE INVESTIGACIÓN SIN REVISIÓN"
			        elsif(si.estatus_id==14)
			            @st = "ENVIADO A CONSEJO DE FACULTAD SIN REVISIÓN"
			        elsif(si.estatus_id==18)
			            @st = "ENVIADO A CONSEJO DE ESCUELA SIN REVISIÓN"
					end
					if @inf.tipo_id == 1
			          	@tipos.push('Semestral')
			        elsif @inf.tipo_id ==2
			            @tipos.push('Anual')
			        elsif @inf.tipo_id==3
			            @tipos.push('Final')
			        else
			          	@tipos.push('')
			        end
					@status.push(@st)
					@nombre_tutor.push(Persona.where(usuario_id: @pf.tutor_id).take.nombres)
					@nombre_instructor.push(Persona.where(usuario_id: @pf.instructor_id).take.nombres)
				else
					@tutor_escuela = Usuarioentidad.where(usuario_id: @inf.tutor_id).take
					if @tutor_escuela.escuela_id == @entidad_escuela_id && (@tutor_escuela.departamento_id == @depto || @depto == nil)
						@informe = true
						@informes.push(@inf)
						if @inf.tipo_id == 1
				          	@tipos.push('Semestral')
				        elsif @inf.tipo_id ==2
				            @tipos.push('Anual')
				        elsif @inf.tipo_id==3
				            @tipos.push('Final')
			          	else
			          		@tipos.push('')  	
			            end
						if(si.estatus_id==1)
							@st = "APROBADO POR CONSEJO DE FACULTAD"
						elsif(si.estatus_id==2)
							@st = "ENVIADO A CONSEJO TÉCNICO"
						elsif(si.estatus_id==3)
							@st = "ENVIADO A COMISION DE INVESTIGACIÓN"
						elsif(si.estatus_id==4)
							@st = "ENVIADO A CONSEJO DE FACULTAD"
						elsif(si.estatus_id==5)
							@st = "APROBADO CON OBSERVACIONES POR CONSEJO DE FACULTAD"
						elsif(si.estatus_id==8)
							@st = "ENVIADO A CONSEJO DE ESCUELA"
						elsif(si.estatus_id==9)
							@st = "RECHAZADO POR CONSEJO DE FACULTAD"
				        elsif(si.estatus_id==12)
				            @st = "ENVIADO A CONSEJO TÉCNICO SIN REVISIÓN"
				        elsif(si.estatus_id==13)
				            @st = "ENVIADO A COMISIÓN DE INVESTIGACIÓN SIN REVISIÓN"
				        elsif(si.estatus_id==14)
				            @st = "ENVIADO A CONSEJO DE FACULTAD SIN REVISIÓN"
				        elsif(si.estatus_id==18)
				            @st = "ENVIADO A CONSEJO DE ESCUELA SIN REVISIÓN"
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
	    if session[:usuario_id] && session[:entidad] == true
			@cjpTipo=Usuario.find(session[:usuario_id]).tipo
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
		      	elsif @informe.tipo_id == 2
		          	@nombre_informe= @nombre_informe+"ANUAL"
		        else
		          	@nombre_informe= "INFORME "+"FINAL"
		        end

		      	@estatus= EstatusInforme.where(informe_id: @informe.id, actual: 1).take
		      	@status= TipoEstatus.find(@estatus.estatus_id)
		      	@userentidad=Usuarioentidad.where(entidad_id: session[:entidad_id]).take
		      	@userentidadUsuario=Usuarioentidad.where(usuario_id: @informe.tutor_id).take
				@escuela= Escuela.where(id: @userentidadUsuario.escuela_id).take
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
			if(estatusI.estatus_id != 3 && estatusI.estatus_id != 13)
				@bool_enviado = 1
			end
		elsif (session[:entidad_id] >= 14 && session[:entidad_id] <= 17)
		#Consejo tecnico
			estatusI = EstatusInforme.where(informe_id: @informe.id, actual: 1).take
			if(estatusI.estatus_id != 2 && estatusI.estatus_id != 12)
				@bool_enviado = 1
			end
		elsif (session[:entidad_id] >= 1 && session[:entidad_id] <= 6)
		#Consejo de escuela
			estatusI = EstatusInforme.where(informe_id: @informe.id, actual: 1).take 
			if(estatusI.estatus_id != 8 && estatusI.estatus_id != 18)
				@bool_enviado = 1 #Estatus enviado a consejo escuela
			end
		elsif (session[:entidad_id] == 13)
			#Consejo de facultad
			estatusI = EstatusInforme.where(informe_id: @informe.id, actual: 1).take
			if(estatusI.estatus_id != 4 && estatusI.estatus_id != 14)
				@bool_enviado = 1
			end
		end	
	end


	def detalles_informe2
		@cjpTipo=Usuario.find(session[:usuario_id]).tipo
		@nombre = session[:nombre_usuario]
		if !session[:informe_id].blank?
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
	    	@semestres=[]
	      	@CJagregado=["no","no","no","no"]
	    	@resultados= []
	    	@resultados2= ""
	    	@resultados2a= []
	    	@resultados2b= []
	    	@actividadese= []
	    	@observaciont= []
	    	@observacionesExtras = []
	    	@revision= Revision.where(informe_id: @informe.id, usuario_id: session[:usuario_id], adecuacion_id: @adecuacion.id).take
	    	@actividadesa.each do |actade| 
	    		if @resultados2b != []
	    			@resultados2b= Array.new(0) { |i|  }
	    		end
		      	if actade.actividad_id == nil #Es el caso que es un resultado no contemplado en el plan de formacion o un avancwe de postgrado
		        	@res= Resultado.where(informe_actividad_id: actade.id).all
		        	@resultados.push(@res)
		        	@actividadese.push("")
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
			       		if !@cparray.blank?
				        	@noemptyarray = @cparray - ["", nil]
				        	if !@resultados2
					        	@noemptyarray = @cparray - ["", nil]
					        	if !@noemptyarray.join(',').blank?
						        	@resultados2 = @noemptyarray.join(',')
						        end
					        else
					        	@noemptyarray = @cparray - ["", nil]
					        	if !@noemptyarray.join(',').blank?
						        	@resultados2 = @noemptyarray.join(',')
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
			        @cpObs2= ObservacionTutor.where(informe_actividad_id: actade.id).take 
			        cpVerificar = "si"
			        if !@cpObs2.blank? && !@cpObs2.observaciones.blank? 
			        	@observacionesExtras.push("si")
			        	cpVerificar = "no"
			        end
			        if @obs==nil
			          	@observaciont.push("")

			          	if cpVerificar == "si"
				          	@cpObs= ObservacionActividadInforme.where(informe_actividad_id: actade.id).all
						    if @cpObs.blank?
						    	@observacionesExtras.push("no")
						    else

								cpBool = 0
								@cpObs.each do |probar|
									if !probar.observaciones.blank?
										cpBool = 1
									end
								end

						    	if cpBool == 0
						    		@observacionesExtras.push("no")
						    	else
						    		@observacionesExtras.push("si")
						    	end
						    end
						end
			        else
			          	@observaciont.push(@obs.observaciones)

			          	if cpVerificar == "si"
				          	@cpObs= ObservacionActividadInforme.where(informe_actividad_id: actade.id).where.not(revision_id: @revision.id).all
						    if @cpObs.blank?
						    	@observacionesExtras.push("no")
						    else
								cpBool = 0
								@cpObs.each do |probar|
									if !probar.observaciones.blank?
										cpBool = 1
									end
								end

						    	if cpBool == 0
						    		@observacionesExtras.push("no")
						    	else
						    		@observacionesExtras.push("si")
						    	end
						    end
						end
			        end

		     	else
			        @act= Actividad.find(actade.actividad_id)
			        tipo= @act.tipo_actividad_id
			        @res= Resultado.where(informe_actividad_id: actade.id).all
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
				       		if !@cparray.blank?
					        	@noemptyarray = @cparray - ["", nil]
					        	if !@resultados2
						        	@noemptyarray = @cparray - ["", nil]
						        	if !@noemptyarray.join(',').blank?
							        	@resultados2 = @noemptyarray.join(',')
							        end
						        else
						        	@noemptyarray = @cparray - ["", nil]
						        	if !@noemptyarray.join(',').blank?
							        	@resultados2 = @noemptyarray.join(',')
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
			        	
			        	@actividadese.push(@ae)
			        end

			        if @revision == nil || @revision == ""
			        	@obs=nil
			        else
			        	@obs= ObservacionActividadInforme.where(informe_actividad_id: actade.id, revision_id: @revision.id).take
			        end

			        @cpObs2= ObservacionTutor.where(informe_actividad_id: actade.id).take 
			        cpVerificar = "si"
			        if !@cpObs2.blank? && !@cpObs2.observaciones.blank? 
			        	@observacionesExtras.push("si")
			        	cpVerificar = "no"
			        end
			        if @obs==nil
			          	@observaciont.push("")

			          	if cpVerificar == "si"
				          	@cpObs= ObservacionActividadInforme.where(informe_actividad_id: actade.id).all
						    if @cpObs.blank?
						    	@observacionesExtras.push("no")
						    else

								cpBool = 0
								@cpObs.each do |probar|
									if !probar.observaciones.blank?
										cpBool = 1
									end
								end

						    	if cpBool == 0
						    		@observacionesExtras.push("no")
						    	else
						    		@observacionesExtras.push("si")
						    	end
						    end
						end
			        else
			          	@observaciont.push(@obs.observaciones)

			          	if cpVerificar == "si"
				          	@cpObs= ObservacionActividadInforme.where(informe_actividad_id: actade.id).where.not(revision_id: @revision.id).all
						    if @cpObs.blank?
						    	@observacionesExtras.push("no")
						    else
								cpBool = 0
								@cpObs.each do |probar|
									if !probar.observaciones.blank?
										cpBool = 1
									end
								end

						    	if cpBool == 0
						    		@observacionesExtras.push("no")
						    	else
						    		@observacionesExtras.push("si")
						    	end
						    end
						end
			        end
			          semestre = AdecuacionActividad.where(actividad_id: @act.id).take.semestre
			          @semestres[@act.id]=semestre
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
	    	end
	    	@bool_enviado = 0
			if (session[:entidad_id] >= 7 && session[:entidad_id] <= 12)
				#Usuario comision
				estatusI = EstatusInforme.where(informe_id: @informe.id, actual: 1).take #Estatus enviado a comision de investigacioni
				if(estatusI.estatus_id != 3 && estatusI.estatus_id != 13)
					@bool_enviado = 1
				end
			elsif (session[:entidad_id] >= 14 && session[:entidad_id] <= 17)
				#Consejo tecnico
				estatusI = EstatusInforme.where(informe_id: @informe.id, actual: 1).take
				if(estatusI.estatus_id != 2 && estatusI.estatus_id != 12)
					@bool_enviado = 1
				end
			elsif (session[:entidad_id] >= 1 && session[:entidad_id] <= 6)
				#Consejo de escuela
				estatusI = EstatusInforme.where(informe_id: @informe.id, actual: 1).take 
				if(estatusI.estatus_id != 8 && estatusI.estatus_id != 18)
					@bool_enviado = 1 #Estatus enviado a consejo escuela
				end
			elsif (session[:entidad_id] == 13)
				#Consejo de facultad
				estatusI = EstatusInforme.where(informe_id: @informe.id, actual: 1).take
				if(estatusI.estatus_id != 4 && estatusI.estatus_id != 14)
					@bool_enviado = 1
				end
			end
		else
		    flash[:info]= "Seleccione un informe"
		    redirect_to controller:"inicioentidad", action: "listar_informes"
		end	
 	end

	def vista_previa1  
	  if !session[:informe_id].blank?
		@cjpTipo=Usuario.find(session[:usuario_id]).tipo
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
	    @CJagregado=["no","no","no","no"]
	    @semestres = []


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
				@actividades1doc.push(@act)
			elsif tipo==2
				if @informe.numero == 1
					@resActi= InformeActividad.where(informe_id: @informe.id, actividad_id: @act.id).take
					@res= Resultado.where(informe_actividad_id: @resActi.id).all
				end
			  	@actividades1inv.push(@act)
			elsif tipo==3
			    @actividades1ext.push(@act)
			elsif tipo==4
			    @actividades1for.push(@act)
			elsif tipo==5
			    @actividades1otr.push(@act)
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
			elsif tipo==2
			  	@actividades2inv.push(@act)
			elsif tipo==3
			    @actividades2ext.push(@act)
			elsif tipo==4
			    @actividades2for.push(@act)
			elsif tipo==5
			    @actividades2otr.push(@act)
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
			elsif tipo==2
			 	@actividades3inv.push(@act)
			elsif tipo==3
			    @actividades3ext.push(@act)
			elsif tipo==4
			    @actividades3for.push(@act)
			elsif tipo==5
			    @actividades3otr.push(@act)
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
			elsif tipo==2
			  	@actividades4inv.push(@act)
			elsif tipo==3
			    @actividades4ext.push(@act)
			elsif tipo==4
			    @actividades4for.push(@act)
			elsif tipo==5
			    @actividades4otr.push(@act)
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
	      if tipo==1
	        @actividades5doc.push(@act)
	      elsif tipo==2
	          @actividades5inv.push(@act)
	      elsif tipo==3
	        @actividades5ext.push(@act)
	      elsif tipo==4
	        @actividades5for.push(@act)
	      end
	    end

	    @bool_enviado = 0
	    estatus_informe = EstatusInforme.where(informe_id: @informe.id, actual: 1).take
	    if (estatus_informe.estatus_id != 6 && estatus_informe.estatus_id != 5)
	      @bool_enviado = 1
	    end

	    actividades = AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: 0)
	    actividades1 = []
	    if !actividades.blank?
	      actividades.each do |actividadAde|
	        actividad = Actividad.find(actividadAde.actividad_id)
	        actividades1.push(actividad)
	      end
	    end
	    @presentacion = ""
	    @descripcion = ""
	    @docencia = [] 
	    @investigacion = []
	    @formacion = []  
	    @extension = []

	    if !actividades1.blank?
	      actividades1.each do |actividadAde|
	        if actividadAde.tipo_actividad_id == 9
	          if actividadAde.actividad.blank?
	            @presentacion = " "
	          else
	            @presentacion = actividadAde.actividad 
	          end
	        elsif actividadAde.tipo_actividad_id == 8
	          if actividadAde.actividad.blank?
	            @descripcion = " "
	          else
	            @descripcion = actividadAde.actividad  
	          end
	        elsif actividadAde.tipo_actividad_id == 1
	          if actividadAde.actividad.blank?
	            @docencia.push(" ")
	          else
	            @docencia.push(actividadAde)
	          end
	        elsif actividadAde.tipo_actividad_id == 2
	          if actividadAde.actividad.blank?
	            @investigacion.push(" ")
	          else
	            @investigacion.push(actividadAde)
	          end
	        elsif actividadAde.tipo_actividad_id == 4
	          if actividadAde.actividad.blank?
	            @formacion.push(" ")
	          else
	            @formacion.push(actividadAde)  
	          end
	        elsif actividadAde.tipo_actividad_id == 3
	          if actividadAde.actividad.blank?
	            @extension.push(" ")
	          else
	            @extension.push(actividadAde)
	          end
	        end
	      end
	    else
	      @presentacion = " "
	      @descripcion = " "
	      @docencia = [" "]  
	      @investigacion = [" "]
	      @formacion = [" "] 
	      @extension = [" "] 
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
	                  @resultados2 = "* " + @noemptyarray
	                end
	              else
	                @noemptyarray = @cparray - ["", nil]
	                if !@noemptyarray.join(',').blank?
	                  @resultados2 = @resultados2 + @noemptyarray.join(', ')
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
	                  @resultados2 = "* " + @noemptyarray
	                end
	              else
	                @noemptyarray = @cparray - ["", nil]
	                if !@noemptyarray.join(',').blank?
	                  @resultados2 = @resultados2 + @noemptyarray.join(', ')
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
		  semestre = AdecuacionActividad.where(actividad_id: @act.id).take.semestre
		  @semestres[@act.id]=semestre
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
			if(estatusI.estatus_id != 3 && estatusI.estatus_id != 13)
				@bool_enviado = 1
			end
		elsif (session[:entidad_id] >= 14 && session[:entidad_id] <= 17)
		#Consejo tecnico
			estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
			if(estatusI.estatus_id != 2 && estatusI.estatus_id != 12)
				@bool_enviado = 1
			end
		elsif (session[:entidad_id] >= 1 && session[:entidad_id] <= 6)
		#Consejo de escuela
			estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take 
			if(estatusI.estatus_id != 8 && estatusI.estatus_id != 18)
				@bool_enviado = 1 #Estatus enviado a consejo escuela
			end
		elsif (session[:entidad_id] == 13)
		#Consejo de facultad
			estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
			if(estatusI.estatus_id != 4 && estatusI.estatus_id != 14)
				@bool_enviado = 1
			end
		end

		else
			flash[:info]="Selecciona un informe"
			redirect_to controller: "inicioentidad", action: "listar_informes"
		end
	end

	#Funcion para guardar observaciones
 	def guardar_observaciones
 		if session[:usuario_id] && session[:entidad] == true
			@cjpTipo=Usuario.find(session[:usuario_id]).tipo
 
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
		      	j=0
			    i=:obli.to_s+j.to_s
			    @act = params[i].to_i
		      	while j <  @cant_obli
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

 	#Cerrar Sesión
	def logout
		reset_session
		redirect_to controller: "forminst", action: "index"
	end
	#Observaciones de informe
	def mas_observaciones
		@boolobs= 0
		@booltutor = 0
		@informe_id = params[:informe_id].to_i
		@actividad_id = params[:actividad_id].to_i
			@cjpTipo=Usuario.find(session[:usuario_id]).tipo
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
			elsif (entidad.entidad_id  >= 14 && entidad.entidad_id  <= 17)
			#Consejo tecnico
				@obs_consejoT = obs.observaciones
			elsif (entidad.entidad_id  >= 1 && entidad.entidad_id  <= 6)
			#Consejo de escuela
				@obs_consejoE = obs.observaciones
			elsif (entidad.entidad_id  == 13)
			#Consejo de facultad
				@obs_consejoF =  obs.observaciones
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
			if(estatusI.estatus_id != 3 && estatusI.estatus_id != 13)
				@bool_enviado = 1
			end
		elsif (session[:entidad_id] >= 14 && session[:entidad_id] <= 17)
		#Consejo tecnico
			estatusI = EstatusInforme.where(informe_id: @informe_id, actual: 1).take
			if(estatusI.estatus_id != 2 && estatusI.estatus_id != 12)
				@bool_enviado = 1
			end
		elsif (session[:entidad_id] >= 1 && session[:entidad_id] <= 6)
			#Consejo de escuela
			estatusI = EstatusInforme.where(informe_id: @informe_id, actual: 1).take 
			if(estatusI.estatus_id != 8 && estatusI.estatus_id != 18)
				@bool_enviado = 1 #Estatus enviado a consejo escuela
			end
		elsif (session[:entidad_id] == 13)
		#Consejo de facultad
			estatusI = EstatusInforme.where(informe_id: @informe_id, actual: 1).take
			if(estatusI.estatus_id != 4 && estatusI.estatus_id != 14)
				@bool_enviado = 1
			end
		end	
	end

	def mas_observaciones2
		@boolobsb = 0
		@informe_id = params[:informe_id].to_i
		@resultado_id = params[:resultado_id].to_i
		@cjpTipo=Usuario.find(session[:usuario_id]).tipo
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
			if(estatusI.estatus_id != 3 && estatusI.estatus_id != 13)
				@bool_enviado = 1
 			end
		elsif (session[:entidad_id] >= 14 && session[:entidad_id] <= 17)
		#Consejo tecnico
			estatusI = EstatusInforme.where(informe_id: @informe_id, actual: 1).take
			if(estatusI.estatus_id != 2 && estatusI.estatus_id != 12)
				@bool_enviado = 1
			end
		elsif (session[:entidad_id] >= 1 && session[:entidad_id] <= 6)
			#Consejo de escuela
			estatusI = EstatusInforme.where(informe_id: @informe_id, actual: 1).take 
			if(estatusI.estatus_id != 8 && estatusI.estatus_id != 18)
				@bool_enviado = 1 #Estatus enviado a consejo escuela
			end
		elsif (session[:entidad_id] == 13)
		#Consejo de facultad
			estatusI = EstatusInforme.where(informe_id: @informe_id, actual: 1).take
			if(estatusI.estatus_id != 4 && estatusI.estatus_id != 14)
				@bool_enviado = 1
			end
		end
		
	end

	#Visualizar los respaldos
	def ver_respaldos
		if session[:usuario_id] && session[:entidad] 
		  @cjpTipo=Usuario.find(session[:usuario_id]).tipo
		  @plan = Planformacion.where(id: session[:plan_id]).take
		  @adec = Adecuacion.where(planformacion_id: session[:plan_id]).take
		  @documents = []
		  if !session[:informe_id].blank?
		    @documents = Respaldo.where(adecuacion_id: @adec.id, informe_id: session[:informe_id]).all
		  else
		    @documents = Respaldo.where(adecuacion_id: session[:adecuacion_id], informe_id: nil).all
		  end
		else
		  redirect_to controller:"forminst", action: "index"
		end
	end
	#Descargar respaldos
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

	def guardar_obs_primera_parte
 		if session[:usuario_id] && session[:entidad]== true
 			@semestre = params[:semestre].to_i
 			@vista_adecuacion = @semestre + 2
		    @adecuacion= Adecuacion.find(session[:adecuacion_id])
		    @estatus= EstatusAdecuacion.where(adecuacion_id: @adecuacion.id).take
		



			revision= Revision.where(usuario_id: session[:usuario_id], adecuacion_id: @adecuacion.id, estatus_id: @estatus.estatus_id, informe_id: nil).take 
	     

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

        	#presentacion
      		aa= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: 0, actividad_id: params[:presentacionId]).take
      			oa= ObservacionActividadAdecuacion.where(adecuacionactividad_id: aa.id, revision_id: revision.id).take

      		if(oa == nil || oa =="")
	          	oa = ObservacionActividadAdecuacion.new
	          	oa.adecuacionactividad_id = aa.id
	          	oa.revision_id =  revision.id
	          	oa.observaciones = params[:obsPresentacion]
	          	oa.actual = 1
	          	oa.save
	        else
	       		oa.observaciones = params[:obsPresentacion]
	       		oa.save
	       	end

	       	#Descripcion
      		aa= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: 0, actividad_id: params[:descripcionId]).take
      			oa= ObservacionActividadAdecuacion.where(adecuacionactividad_id: aa, revision_id: revision.id).take

      		if(oa == nil || oa =="")
	          	oa = ObservacionActividadAdecuacion.new
	          	oa.adecuacionactividad_id = aa.id
	          	oa.revision_id =  revision.id
	          	oa.observaciones = params[:obsDescripcion]
	          	oa.actual = 1
	          	oa.save
	        else
	       		oa.observaciones = params[:obsDescripcion]
	       		oa.save
	       	end

	       	#Docencia
      		aa= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: 0, actividad_id: params[:docenciaId]).take
      			oa= ObservacionActividadAdecuacion.where(adecuacionactividad_id: aa, revision_id: revision.id).take

      		if(oa == nil || oa =="")
	          	oa = ObservacionActividadAdecuacion.new
	          	oa.adecuacionactividad_id = aa.id
	          	oa.revision_id =  revision.id
	          	oa.observaciones = params[:obsDocencia]
	          	oa.actual = 1
	          	oa.save
	        else
	       		oa.observaciones = params[:obsDocencia]
	       		oa.save
	       	end

	       	#Investigacion
      		aa= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: 0, actividad_id: params[:investigacionId]).take
      			oa= ObservacionActividadAdecuacion.where(adecuacionactividad_id: aa, revision_id: revision.id).take

      		if(oa == nil || oa =="")
	          	oa = ObservacionActividadAdecuacion.new
	          	oa.adecuacionactividad_id = aa.id
	          	oa.revision_id =  revision.id
	          	oa.observaciones = params[:obsInvestigacion]
	          	oa.actual = 1
	          	oa.save
	        else
	       		oa.observaciones = params[:obsInvestigacion]
	       		oa.save
	       	end

	       	#Formacion
      		aa= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: 0, actividad_id: params[:formacionId]).take
      			oa= ObservacionActividadAdecuacion.where(adecuacionactividad_id: aa, revision_id: revision.id).take

      		if(oa == nil || oa =="")
	          	oa = ObservacionActividadAdecuacion.new
	          	oa.adecuacionactividad_id = aa.id
	          	oa.revision_id =  revision.id
	          	oa.observaciones = params[:obsFormacion]
	          	oa.actual = 1
	          	oa.save
	        else
	       		oa.observaciones = params[:obsFormacion]
	       		oa.save
	       	end

	       	#Extension
      		aa= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: 0, actividad_id: params[:extensionId]).take
      			oa= ObservacionActividadAdecuacion.where(adecuacionactividad_id: aa, revision_id: revision.id).take

      		if(oa == nil || oa =="")
	          	oa = ObservacionActividadAdecuacion.new
	          	oa.adecuacionactividad_id = aa.id
	          	oa.revision_id =  revision.id
	          	oa.observaciones = params[:obsExtension]
	          	oa.actual = 1
	          	oa.save
	        else
	       		oa.observaciones = params[:obsExtension]
	       		oa.save
	       	end

	      

	      	flash[:success]="Se han creado y/o modificado las observaciones satisfactoriamente"
	      	redirect_to controller:"inicioentidad", action: "detalles_adecuacion2"
 		end
 	end

	def guardar_observaciones2
 		if session[:usuario_id] && session[:entidad]== true
 			@semestre = params[:semestre].to_i
			@cjpTipo=Usuario.find(session[:usuario_id]).tipo
 			@vista_adecuacion = @semestre + 2
		    @adecuacion= Adecuacion.find(session[:adecuacion_id])
		    puts "holaaaaaaaaaaaaaaa"
		    puts session[:adecuacion_id]
		    @estatus= EstatusAdecuacion.where(adecuacion_id: @adecuacion.id).take
		    @cant_doc= params[:cant_docencia].to_i
		    @cant_inv= params[:cant_investigacion].to_i
		    @cant_for= params[:cant_formacion].to_i
		    @cant_ext= params[:cant_extension].to_i
		    @cant_obli= params[:cant_obligatoria].to_i
		    @cant_otr= params[:cant_otra].to_i
		



			revision= Revision.where(usuario_id: session[:usuario_id], adecuacion_id: @adecuacion.id, estatus_id: @estatus.estatus_id, informe_id: nil).take 

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

        	if params[:prim_part] == "si"
				#presentacion
	      		aa= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: 0, actividad_id: params[:presentacionId]).take
	      			oa= ObservacionActividadAdecuacion.where(adecuacionactividad_id: aa.id, revision_id: revision.id).take

	      		if(oa == nil || oa =="")
		          	oa = ObservacionActividadAdecuacion.new
		          	oa.adecuacionactividad_id = aa.id
		          	oa.revision_id =  revision.id
		          	oa.observaciones = params[:obsPresentacion]
		          	oa.actual = 1
		          	oa.save
		        else
		       		oa.observaciones = params[:obsPresentacion]
		       		oa.save
		       	end

		       	#Descripcion
	      		aa= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: 0, actividad_id: params[:descripcionId]).take
	      			oa= ObservacionActividadAdecuacion.where(adecuacionactividad_id: aa, revision_id: revision.id).take

	      		if(oa == nil || oa =="")
		          	oa = ObservacionActividadAdecuacion.new
		          	oa.adecuacionactividad_id = aa.id
		          	oa.revision_id =  revision.id
		          	oa.observaciones = params[:obsDescripcion]
		          	oa.actual = 1
		          	oa.save
		        else
		       		oa.observaciones = params[:obsDescripcion]
		       		oa.save
		       	end
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

	      

	      	flash[:success]="Se han creado y/o modificado las observaciones satisfactoriamente"

	      	if(@semestre == 0)
	      			redirect_to controller:"inicioentidad", action: "detalles_adecuacion2"
	      	end
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

 	def mas_observaciones3 #mas obs de actividades del Adecuación
 		@boolobs = 0
 		@adecuacion= Adecuacion.find(session[:adecuacion_id])
		@cjpTipo=Usuario.find(session[:usuario_id]).tipo
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
			elsif (entidad.entidad_id  >= 14 && entidad.entidad_id  <= 17)
			#Consejo tecnico
				@obs_consejoT = obs.observaciones
			elsif (entidad.entidad_id  >= 1 && entidad.entidad_id  <= 6)
			#Consejo de escuela
				@obs_consejoE = obs.observaciones
			elsif (entidad.entidad_id  == 13)
			#Consejo de facultad
				@obs_consejoF =  obs.observaciones
			end
		end
		@bool_enviado = 0
		if (session[:entidad_id] >= 7 && session[:entidad_id] <= 12)
		#Usuario comision
			estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take #Estatus enviado a comision de investigacioni
			if(estatusI.estatus_id != 3 && estatusI.estatus_id != 13)
				@bool_enviado = 1
			end
		elsif (session[:entidad_id] >= 14 && session[:entidad_id] <= 17)
		#Consejo tecnico
			estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
			if(estatusI.estatus_id != 2 && estatusI.estatus_id != 12)
				@bool_enviado = 1
			end
		elsif (session[:entidad_id] >= 1 && session[:entidad_id] <= 6)
		#Consejo de escuela
			estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take 
			if(estatusI.estatus_id != 8 && estatusI.estatus_id != 18)
				@bool_enviado = 1 #Estatus enviado a consejo escuela
			end
		elsif (session[:entidad_id] == 13)
		#Consejo de facultad
			estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
			if(estatusI.estatus_id != 4 && estatusI.estatus_id != 14)
				@bool_enviado = 1
			end
		end
	end

	def cambiar_estatusI
		@informe_id = params[:informe_id].to_i
		rechazar = params[:rechazar].to_i
		@cjpTipo=Usuario.find(session[:usuario_id]).tipo
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
			elsif(user.escuela_id == 2)
				uentidad = Usuarioentidad.where(escuela_id: user.escuela_id, entidad_id: 2).take
			elsif(user.escuela_id == 3)
				uentidad = Usuarioentidad.where(escuela_id: user.escuela_id, entidad_id: 3).take
			elsif(user.escuela_id == 4)
				uentidad = Usuarioentidad.where(escuela_id: user.escuela_id, entidad_id: 4).take
			elsif(user.escuela_id == 9)
			    uentidad = Usuarioentidad.where(escuela_id: user.escuela_id, entidad_id: 5).take
			elsif(user.escuela_id == 10)
				uentidad = Usuarioentidad.where(escuela_id: user.escuela_id, entidad_id: 6).take
			end
			linkTeI = "http://formacion.ciens.ucv.ve/forminst?accion=mostrar informe&param1=" + plan.id.to_s + "&param2="+ @informe_id.to_s
        	linkE = "http://formacion.ciens.ucv.ve/forminst?accion=mostrar informe&param1=" + plan.id.to_s+ "&param2="+@informe_id.to_s+"&param3="+adec.id.to_s
	          remitente3 = Usuario.where(id: informeAct.tutor_id).take
		      ActionCorreo.envio_informe(remitente3, notific.mensaje,2,linkTeI,@document).deliver
		      remitente2 = Usuario.where(id: plan.instructor_id).take
		      ActionCorreo.envio_informe(remitente2, notific2.mensaje,1,linkTeI,@document).deliver
		      remitente = Usuario.where(id: uentidad.usuario_id).take
		      ActionCorreo.envio_informe(remitente, notific3.mensaje,0,linkE,@document).deliver
	          flash[:success]="El informe se ha envíado a consejo de escuela"
		elsif (session[:entidad_id] >= 14 && session[:entidad_id] <= 17)
			#Consejo tecnico
		elsif (session[:entidad_id] >= 1 && session[:entidad_id] <= 6)
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
			linkTeI = "http://formacion.ciens.ucv.ve/forminst?accion=mostrar informe&param1=" + plan.id.to_s + "&param2="+ @informe_id.to_s
        	linkE = "http://formacion.ciens.ucv.ve/forminst?accion=mostrar informe&param1=" + plan.id.to_s+ "&param2="+@informe_id.to_s+"&param3="+adec.id.to_s
			ActionCorreo.envio_informe(remitente3, notific.mensaje,2,linkTeI,@document).deliver
			remitente2 = Usuario.where(id: plan.instructor_id).take
			ActionCorreo.envio_informe(remitente2, notific2.mensaje,1,linkTeI,@document).deliver
			remitente = Usuario.where(id: uentidad.usuario_id).take
			ActionCorreo.envio_informe(remitente, notific3.mensaje,0,linkE,@document).deliver
			ActionCorreo.envio_informe("consejofacultadcienciasucv@gmail.com", notific3.mensaje,0, linkE,@document).deliver
			flash[:success]="El informe se ha envíado a consejo de facultad"
		elsif (session[:entidad_id] == 13)
			#Consejo de facultad
			bool_observaciones= 0
			acts_informe = InformeActividad.where(informe_id: @informe_id)
			
			if (rechazar == 2)
				bool_observaciones = 1
			end
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
			linkTeI = "http://formacion.ciens.ucv.ve/forminst?accion=mostrar informe&param1=" + plan.id.to_s + "&param2="+ @informe_id.to_s
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
				ActionCorreo.envio_informe(remitente3, notific.mensaje,2,linkTeI,@document).deliver
				remitente2 = Usuario.where(id: plan.instructor_id).take
				ActionCorreo.envio_informe(remitente2, notific2.mensaje,1,linkTeI,@document).deliver
				cpusuario = Usuario.where(id: plan.instructor_id).take
				cpusuario.activo = 0
				cpusuario.save
			elsif bool_observaciones == 1 
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
				ActionCorreo.envio_informe(remitente3, notific.mensaje,2,linkTeI,@document).deliver
				remitente2 = Usuario.where(id: plan.instructor_id).take
				ActionCorreo.envio_informe(remitente2, notific2.mensaje,1,linkTeI,@document).deliver
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
				ActionCorreo.envio_informe(remitente3, notific.mensaje,2,linkTeI,@document).deliver
				remitente2 = Usuario.where(id: plan.instructor_id).take
				ActionCorreo.envio_informe(remitente2, notific2.mensaje,1,linkTeI,@document).deliver
			end
		end	
		redirect_to controller:"inicioentidad", action: "listar_informes"
	end 
	
	def vista_previa
		session[:informe_id]=nil
		@cjpTipo=Usuario.find(session[:usuario_id]).tipo
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

		actividades = AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: 0)
			if !actividades.blank?
				actividades.each do |actividadAde|
					actividad = Actividad.find(actividadAde.actividad_id)
					if actividad.tipo_actividad_id == 9
						@presentacion = actividad.actividad
					elsif actividad.tipo_actividad_id == 8
						@descripcion = actividad.actividad
					end
				end
			else
				@presentacion = " "
				@descripcion = " "	
			end

			@actividades0doc= []
			@actividades0inv= []
			@actividades0ext= []
			@actividades0for= []
			@actividades0otr= []
			@actividades0= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: 0).all
			@actividades0.each do |actade| 
				@act= Actividad.find(actade.actividad_id)
				tipo= @act.tipo_actividad_id
				if tipo==1
					@actividades0doc.push(@act)
				elsif tipo==2
					@actividades0inv.push(@act)
				elsif tipo==3
					@actividades0ext.push(@act)
				elsif tipo==4
					@actividades0for.push(@act)
				elsif tipo==5
					@actividades0otr.push(@act)
				end
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
			elsif tipo==2
				@actividades1inv.push(@act)
			elsif tipo==3
				@actividades1ext.push(@act)
			elsif tipo==4
				@actividades1for.push(@act)
			elsif tipo==5
				@actividades1otr.push(@act)
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
			elsif tipo==2
				@actividades2inv.push(@act)
			elsif tipo==3
				@actividades2ext.push(@act)
			elsif tipo==4
				@actividades2for.push(@act)
			elsif tipo==5
				@actividades2otr.push(@act)
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
			elsif tipo==2
				@actividades3inv.push(@act)
			elsif tipo==3
				@actividades3ext.push(@act)
			elsif tipo==4
				@actividades3for.push(@act)
			elsif tipo==5
				@actividades3otr.push(@act)
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
			elsif tipo==2
				@actividades4inv.push(@act)
			elsif tipo==3
				@actividades4ext.push(@act)
			elsif tipo==4
				@actividades4for.push(@act)
			elsif tipo==5
				@actividades4otr.push(@act)
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
			if tipo==1
				@actividades5doc.push(@act)
			elsif tipo==2
				@actividades5inv.push(@act)
			elsif tipo==3
				@actividades5ext.push(@act)
			elsif tipo==4
				@actividades5for.push(@act)
			elsif tipo==5
				@actividades5otr.push(@act)
			end
		end

		@bool_enviado = 0
		if (session[:entidad_id] >= 7 && session[:entidad_id] <= 12)
		#Usuario comision
			estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take #Estatus enviado a comision de investigacioni
			if(estatusI.estatus_id != 3 && estatusI.estatus_id != 13)
				@bool_enviado = 1
			end
		elsif (session[:entidad_id] >= 14 && session[:entidad_id] <= 17)
		#Consejo tecnico
			estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
			if(estatusI.estatus_id != 2 && estatusI.estatus_id != 12)
				@bool_enviado = 1
			end
		elsif (session[:entidad_id] >= 1 && session[:entidad_id] <= 6)
		#Consejo de escuela
			estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take 
			if(estatusI.estatus_id != 8 && estatusI.estatus_id != 18)
				@bool_enviado = 1 #Estatus enviado a consejo escuela
			
			end
		elsif (session[:entidad_id] == 13)
		#Consejo de facultad
			estatusI = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
			if(estatusI.estatus_id != 4 && estatusI.estatus_id != 14)
				@bool_enviado = 1
			end
		end	
	end

	#Cambia el estatus de la adecuación
	def cambiar_estatusA
		@adecuacion_id = params[:adecuacion_id].to_i
		rechazar = params[:rechazar].to_i
		@cjpTipo=Usuario.find(session[:usuario_id]).tipo
		
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
				linkT = "http://formacion.ciens.ucv.ve/forminst?accion=mostrar adecuacion&param1=" + plan.id.to_s + "&param2=no"
			    linkI = "http://formacion.ciens.ucv.ve/forminst?accion=mostrar adecuacion"			
				linkE = "http://formacion.ciens.ucv.ve/forminst?accion=mostrar adecuacion&param3=" + @adecuacion_id.to_s  
			    remitente3 = Usuario.where(id: plan.tutor_id).take
				ActionCorreo.envio_adecuacion(remitente3, notific.mensaje,2,linkT,@document).deliver
				remitente2 = Usuario.where(id: plan.instructor_id).take
				ActionCorreo.envio_adecuacion(remitente2, notific2.mensaje,1,linkI,@document).deliver
				remitente = Usuario.where(id: uentidad.usuario_id).take
				ActionCorreo.envio_adecuacion(remitente, notific3.mensaje,0,linkE,@document).deliver

			flash[:success]="La adecuación se ha envíado a consejo de escuela"
		elsif (session[:entidad_id] >= 14 && session[:entidad_id] <= 17)
		#Consejo tecnico

		elsif (session[:entidad_id] >= 1 && session[:entidad_id] <= 6)
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
       		linkT = "http://formacion.ciens.ucv.ve/forminst?accion=mostrar adecuacion&param1=" + plan.id.to_s + "&param2=no"
		    linkI = "http://formacion.ciens.ucv.ve/forminst?accion=mostrar adecuacion"			
			linkE = "http://formacion.ciens.ucv.ve/forminst?accion=mostrar adecuacion&param3=" + @adecuacion_id.to_s
			remitente3 = Usuario.where(id: plan.tutor_id).take
			ActionCorreo.envio_adecuacion(remitente3, notific.mensaje,2,linkT,@document).deliver
			remitente2 = Usuario.where(id: plan.instructor_id).take
			ActionCorreo.envio_adecuacion(remitente2, notific2.mensaje,1,linkI,@document).deliver
			remitente = Usuario.where(id: uentidad.usuario_id).take
			ActionCorreo.envio_adecuacion(remitente, notific3.mensaje,0,linkE,@document).deliver
			ActionCorreo.envio_adecuacion("consejofacultadcienciasucv@gmail.com", notific3.mensaje,0, linkE,@document).deliver

			flash[:success]="La adecuación se ha envíado a consejo de facultad"
		elsif (session[:entidad_id] == 13)
		#Consejo de FACULTAD
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
       		linkT = "http://formacion.ciens.ucv.ve/forminst?accion=mostrar adecuacion&param1=" + plan.id.to_s + "&param2=no"
		    linkI = "http://formacion.ciens.ucv.ve/forminst?accion=mostrar adecuacion"			

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
				ActionCorreo.envio_adecuacion(remitente3, notific.mensaje,2,linkT,@document).deliver		##CORREO AL TUTOR
				remitente2 = Usuario.where(id: plan.instructor_id).take
				ActionCorreo.envio_adecuacion(remitente2, notific2.mensaje,1,linkI,@document).deliver		##CORREO AL INSTRUCTOR
			elsif bool_observaciones == 1 
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
				ActionCorreo.envio_adecuacion(remitente3, notific.mensaje,2,linkT,@document).deliver		##CORREO AL TUTOR
				remitente2 = Usuario.where(id: plan.instructor_id).take
				ActionCorreo.envio_adecuacion(remitente2, notific2.mensaje,1,linkI,@document).deliver		##CORREO AL INSTRUCTOR
			else
				@document = Respaldo.where(adecuacion_id: session[:adecuacion_id], informe_id: nil, actual: 1).take
				@document.estatus = "Aprobado por Consejo de Facultad"
				@document.actual = 0
				@document.save
				flash[:info]="La adecuación ha sido aprobado por consejo de facultad"
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
				ActionCorreo.envio_adecuacion(remitente3, notific.mensaje,2,linkT,@document).deliver		##CORREO AL TUTOR
				remitente2 = Usuario.where(id: plan.instructor_id).take
				ActionCorreo.envio_adecuacion(remitente2, notific2.mensaje,1,linkI,@document).deliver		##CORREO AL INSTRUCTOR
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
		redirect_to controller:"inicioentidad", action: "listar_adecuaciones"
	end 

	def borrar_notificaciones #Funcion para borrar las notificaciones
		if session[:usuario_id] && session[:entidad] == true
			@noti= params[:noti]
			@cjpTipo=Usuario.find(session[:usuario_id]).tipo
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

	def destroyNotifications
		@post = Notificacion.find(params[:id])
		respond_to do |format|
			if @post.destroy
				format.html { redirect_to :back }
			else
				flash[:notice] = "Post failed to delete."
				format.html { redirect_to :back }
			end
		end
	end
end