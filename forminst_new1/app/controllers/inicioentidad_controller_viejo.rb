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
			if ((session[:usuario_id] >= 1 && session[:usuario_id] <= 6) || (session[:usuario_id] >= 14 && session[:usuario_id] <= 17))
				puts session[:entidad_id]
				puts session[:entidad_id]
				puts session[:entidad_id]
				puts session[:entidad_id]
				puts session[:entidad_id]
				puts session[:entidad_id]
				puts session[:entidad_id]
				puts session[:entidad_id]
				puts session[:entidad_id]
				# Este if valida que el id de usuario corersponda a comision o escuela
				#Esto es si es enviado comision(tipo_estatus_id:3) o consejo tecnico(tipo_estatus_id:2) 
				@nombre = session[:nombre_usuario]
				@usu=Usuarioentidad.where(entidad_id: session[:entidad_id]).take
				@comision_escuela_id= @usu.escuela_id
				@adecuaciones = []
				@status = []
				@nombre_tutor = []
				@nombre_instructor = []
				@status_inv = EstatusAdecuacion.where(estatus_id: 3, actual: 1) #Estatus enviado a comision de investigacion
				@status_inv.each do |si|
					@adec= Adecuacion.find(si.adecuacion_id)
					@pf = Planformacion.find(@adec.planformacion.id)
					@tutor_escuela = Usuarioentidad.where(usuario_id: @adec.tutor_id).take
					if @tutor_escuela.escuela_id == @comision_escuela_id
						@adecuacion = true
						@adecuaciones.push(@adec)
						@status.push("ENVIADO A COMISION DE INVESTIGACION")
						@nombre_tutor.push(Persona.where(usuario_id: @pf.tutor_id).take.nombres)
						@nombre_instructor.push(Persona.where(usuario_id: @pf.instructor_id).take.nombres)
					end
				end
			end
			
		else
			redirect_to controller:"forminst", action: "index"
		end

	end

	def prueba2
		if session[:usuario_id]
			#Esto es si es enviado a consejo de escuela (id:8) 
			@nombre = session[:nombre_usuario]
			@usu=Usuarioentidad.where(entidad_id: session[:entidad_id]).take
			@consejo_escuela_id= @usu.escuela_id
			@adecuaciones = []
			@status_inv = EstatusAdecuacion.where(estatus_id: 8, actual: 1) #Estatus enviado a comision de investigacion
			@status_inv.each do |si|
				@adec= Adecuacion.find(si.adecuacion_id)
				@tutor_escuela = Usuarioentidad.where(usuario_id: @adec.tutor_id).take
				if @tutor_escuela.escuela_id == @consejo_escuela_id
					@adecuacion = true
					@adecuaciones.push(@adec)
				end
			end
			
		else
			redirect_to controller:"forminst", action: "index"
		end

	end

	def prueba #para consejo de facultad (id:4)
		if session[:usuario_id]
			
			#Esto es si es enviado a consejo de facultado(tipo_estatus_id:3) o consejo tecnico(tipo_estatus_id:2) 
			@nombre = session[:nombre_usuario]
			@adecuaciones = []
			@status_inv = EstatusAdecuacion.where(estatus_id: 4, actual: 1) #Estatus enviado a consejo de facultad
			@status_inv.each do |si|
				@adec= Adecuacion.find(si.adecuacion_id)
				@adecuaciones.push(@adec)
				
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
			@adecuacion= Adecuacion.find(session[:adecuacion_id])
			@plan= Planformacion.find(@adecuacion.planformacion_id)
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
			@adecuacion= Adecuacion.find(session[:adecuacion_id])
			@plan= Planformacion.find(@adecuacion.planformacion_id)
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
			@adecuacion= Adecuacion.find(session[:adecuacion_id])
			@plan= Planformacion.find(@adecuacion.planformacion_id)
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
			@adecuacion= Adecuacion.find(session[:adecuacion_id])
			@plan= Planformacion.find(@adecuacion.planformacion_id)
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
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def logout
		reset_session
		redirect_to controller: "forminst", action: "index"
	end

end