class InicioinstructorController < ApplicationController
	layout 'ly_inicio_entidad'

	def index
		if session[:usuario_id]
			session[:adecuacion_id] = nil
			session[:plan_id] = nil
			session[:instructorName] = nil
			
			@nombre = session[:nombre_usuario]
		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def listar_adecuaciones
		if session[:usuario_id]
			@nombre = session[:nombre_usuario]

			@plan_formacion = Planformacion.where(instructor_id: session[:usuario_id]).take
			@adecuacion = Adecuacion.where(planformacion_id: @plan_formacion).take
			@tutor = Persona.where(usuario_id: @adecuacion.tutor_id).take.nombres
			@status_adecuacion = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id).take
			@tipo_status = TipoEstatus.where(id: @status_adecuacion.estatus_id).take.concepto

			puts '--------------------'
			puts @tipo_status
			puts '--------------------'

			if not @adecuacion
				puts '--------------------'
				puts 'NO HAY ADECUACION'
				puts '--------------------'
			end

		else
			redirect_to controller:"forminst", action: "index"
		end
	end

	def prorrogas
		if session[:usuario_id]
	      @persona = Persona.where(usuario_id: session[:usuario_id]).take
	      @nombre = session[:nombre_usuario]
	      @planformacion = Planformacion.where(instructor_id: session[:usuario_id]).take
	      #@tutor = Persona.where(usuario_id: @adecuacion.tutor_id).take.nombres
	      @informes = Informe.where(planformacion_id: @planformacion)
	      @informe = Informe.where(planformacion_id: @planformacion).take
	      session[:informe_id] = nil

	      @tipos= []

	      @informes.each do |inf|
	        if inf.tipo_id == 1
	          @tipos.push('Semestral')
	        else
	          if inf.tipo_id ==2
	            @tipos.push('Anual')
	          else
	            if inf.tipo_id==3
	              @tipos.push('Final')
	            end
	          end
	        end
	      end
	      
	      if not @nombre
	        print "NO HAY USUARIO"
	      end
	    else
	      redirect_to controller:"forminst", action: "index"
	    end
	end

	def listar_informes
	    if session[:usuario_id]
	      @persona = Persona.where(usuario_id: session[:usuario_id]).take
	      @nombre = session[:nombre_usuario]
	      @planformacion = Planformacion.where(instructor_id: session[:usuario_id]).take
	      #@tutor = Persona.where(usuario_id: @adecuacion.tutor_id).take.nombres
	      @informes = Informe.where(planformacion_id: @planformacion)
	      @informe = Informe.where(planformacion_id: @planformacion).take
	      session[:informe_id] = nil

	      @tipos= []

	      @informes.each do |inf|
	        if inf.tipo_id == 1
	          @tipos.push('Semestral')
	        else
	          if inf.tipo_id ==2
	            @tipos.push('Anual')
	          else
	            if inf.tipo_id==3
	              @tipos.push('Final')
	            end
	          end
	        end
	      end
	      
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

	def ver_detalles_adecuacion
		if session[:usuario_id]
			@nombre = session[:nombre_usuario]
			@instructorName = session[:nombre_usuario]
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
			@plan = Planformacion.where(instructor_id: session[:usuario_id]).take
			@userentidad= Usuarioentidad.where(usuario_id: session[:usuario_id]).take
			@entidad= Entidad.find(@userentidad.entidad_id)
			@escuela= Escuela.where(id: @userentidad.escuela_id).take
			@tutor = Persona.where(usuario_id: @adecuacion.tutor_id).take

			puts "-------"
			puts @tutor
			puts @escuela
			puts "-------" 
			@instructor= Persona.where(usuario_id: session[:usuario_id]).take

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
			@plan = Planformacion.where(instructor_id: session[:usuario_id]).take
			@userentidad= Usuarioentidad.where(usuario_id: session[:usuario_id]).take
			@entidad= Entidad.find(@userentidad.entidad_id)
			@escuela= Escuela.where(id: @userentidad.escuela_id).take
			@persona= Persona.where(usuario_id: session[:usuario_id]).take
			@usuario= Usuario.find(session[:usuario_id])
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
			@plan = Planformacion.where(instructor_id: session[:usuario_id]).take
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
			@instructorName = session[:instructorName]
			@adecuacion= Adecuacion.find(session[:adecuacion_id])
			@plan = Planformacion.where(instructor_id: session[:usuario_id]).take
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
			@instructorName = session[:instructorName]
			@adecuacion= Adecuacion.find(session[:adecuacion_id])
			@plan = Planformacion.where(instructor_id: session[:usuario_id]).take
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
			@instructorName = session[:instructorName]
			@adecuacion= Adecuacion.find(session[:adecuacion_id])
			@plan = Planformacion.where(instructor_id: session[:usuario_id]).take
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

	def vista_previa
		@fechaActual = Date.current.to_s
		@plan= Planformacion.where(instructor_id: session[:usuario_id]).take
		@usere= Usuarioentidad.where(usuario_id: @plan.instructor_id).take
		@fechaConcurso = @plan.fecha_inicio
		@escuela= Escuela.find(@usere.escuela_id)
		@adecuacion= Adecuacion.where(planformacion_id: @plan.id).take
		@adscripcion_docencia= @plan.adscripcion_docencia
		@adscripcion_investigacion= @plan.adscripcion_investigacion
		@persona= Persona.where(usuario_id: @plan.instructor_id).take
		@cpinstruccion = @persona.grado_instruccion
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

	def ver_detalles_informe
	    if session[:usuario_id]
	      @nombre = session[:nombre_usuario]   
	      if not @nombre
	        print "NO HAY USUARIO"
	      end
	      @persona = Persona.where(usuario_id: session[:usuario_id]).take
	      if session[:plan_id]
	        puts "HAY SESION PLAN"
	        @planformacion = Planformacion.where(instructor_id: session[:usuario_id]).take
	      else
	        puts "NO HAY SESION PLAN"
			session[:plan_id] = Planformacion.where(instructor_id: session[:usuario_id]).take
	        @planformacion = Planformacion.where(instructor_id: session[:usuario_id]).take
	      end
	      if params[:informe_id]!=nil
	        session[:informe_id]= params[:informe_id]
	      end
		  @tutor = Persona.where(usuario_id: @planformacion.tutor_id).take
	      @instructor = Persona.where(usuario_id: @planformacion.instructor_id).take

	      if session[:informe_id] == nil
	      	session[:informe_id] = params[:informe_id]
	      	@informe= Informe.find(session[:informe_id])
	      else 
	      	@informe = Informe.find(session[:informe_id])
	      end

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

	      @estatus= EstatusInforme.where(informe_id: @informe.id).take
	      @status= TipoEstatus.find(@estatus.estatus_id)
	      @userentidad= Usuarioentidad.where(usuario_id: @planformacion.instructor_id).take
	      @entidad= Entidad.find(@userentidad.entidad_id)
	      @escuela= Escuela.find(@userentidad.escuela_id)
	      session[:nombre_informe] = @nombre_informe
	      session[:status_informe] = @status.concepto

	    else
	      redirect_to controller:"forminst", action: "index"
	    end
	end

	def detalles_informe2
    @informe= Informe.find(session[:informe_id])
    @est= EstatusInforme.where(informe_id: @informe.id).take
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
    @actividadesa.each do |actade| 
      if actade.actividad_id == nil #Es el caso que es un resultado no contemplado en el plan de formacion o un avancwe de postgrado
        @res= Resultado.find(actade.resultado_id)
        @resultados.push(@res)
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
        @actividadese.push(@ae)
        @obs= ObservacionTutor.where(informe_actividad_id: actade.id).take
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
    @mes= ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre']
    @dia= [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]
    @tipos= [['Libros',1], ['Artículo de Revista',2], ['Artículo de Prensa',3], ['CD',4], ['Manuales',5], ['Publicaciones Electrónicas',6]]
  	end
end