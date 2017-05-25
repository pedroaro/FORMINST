﻿class InicioinstructorController < ApplicationController
	layout 'ly_inicio_entidad'

	def index
		if session[:usuario_id] && session[:instructor]= true
			session[:adecuacion_id] = nil
      plan = Planformacion.where(instructor_id: session[:usuario_id]).take
			session[:plan_id] = plan.id
			session[:instructorName] = nil
      session[:informe_id] = nil
			@nombre = session[:nombre_usuario]
      @notificaciones1= []
      @notificaciones = Notificacion.where(instructor_id: session[:usuario_id]).all
      @notificaciones.each do |notificaciones|
        puts notificaciones.actual
        if notificaciones.actual == 2        #Caso de notificaciones del instructor
          @notificaciones1.push(notificaciones)
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
      @documents = Document.where(adecuacion_id: session[:adecuacion_id], informe_id: session[:informe_id]).all
    else
      @documents = Document.where(adecuacion_id: session[:adecuacion_id], informe_id: nil).all
    end
  end

	def listar_adecuaciones
		if session[:usuario_id] && session[:instructor]= true
			@nombre = session[:nombre_usuario]

			@plan_formacion = Planformacion.where(instructor_id: session[:usuario_id]).take
			@adecuacion = Adecuacion.where(planformacion_id: @plan_formacion).take
			@tutor = Persona.where(usuario_id: @adecuacion.tutor_id).take.nombres
			@status_adecuacion = EstatusAdecuacion.where(adecuacion_id: @adecuacion.id, actual: 1).take
			@tipo_status = TipoEstatus.where(id: @status_adecuacion.estatus_id, ).take.concepto

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
		if session[:usuario_id] && session[:instructor]= true
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
      end
    end
  else
    flash[:info]="Selecciona un informe"
    redirect_to controller: "inicioinstructor", action: "listar_informes"
  end
end

	def listar_informes
	    if session[:usuario_id] && session[:instructor]= true

	      @persona = Persona.where(usuario_id: session[:usuario_id]).take
	      @nombre = session[:nombre_usuario]
	      @planformacion = Planformacion.where(instructor_id: session[:usuario_id]).take
	      #@tutor = Persona.where(usuario_id: @adecuacion.tutor_id).take.nombres
	      @informes = Informe.where(planformacion_id: @planformacion)
	      @informe = Informe.where(planformacion_id: @planformacion).take
        @status = []
	      session[:informe_id] = nil
	      @tipos= []
	      @informes.each do |inf|
          si = EstatusInforme.where(informe_id: inf.id, actual: 1).take
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
          end
          @status.push(@st)
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
		if session[:usuario_id] && session[:instructor]= true
			@nombre = session[:nombre_usuario]
			@instructorName = session[:nombre_usuario]
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

			@adecuacion= Adecuacion.find(session[:adecuacion_id])
			@plan = Planformacion.where(instructor_id: session[:usuario_id]).take
			@userentidad= Usuarioentidad.where(usuario_id: session[:usuario_id]).take
			@entidad= Entidad.find(@userentidad.entidad_id)
			@escuela= Escuela.where(id: @userentidad.escuela_id).take
			@tutor = Persona.where(usuario_id: @adecuacion.tutor_id).take
      @usuario = Usuario.where(id: session[:usuario_id]).take
      @persona = Persona.where(usuario_id: session[:usuario_id]).take
      @cpTutor= Persona.where(usuario_id: @plan.tutor_id).take
      @cpTutorEmail= Usuario.find(@plan.tutor_id).email

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

	def detalles_adecuacion3
		if session[:usuario_id] && session[:instructor]= true
      session[:informe_id] = nil
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
		if session[:usuario_id] && session[:instructor]= true
			@iddoc= 'id_docencia'
      session[:informe_id] = nil
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
		if session[:usuario_id] && session[:instructor]= true
      session[:informe_id] = nil
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
		if session[:usuario_id] && session[:instructor]= true
      session[:informe_id] = nil
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
    session[:informe_id] = nil
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
    @cpTutor= Persona.where(usuario_id: @plan.tutor_id).take
    @cpTutorEmail= Usuario.find(@plan.tutor_id).email

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
	    if session[:usuario_id] && session[:instructor]= true
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
	        @planformacion = Planformacion.where(instructor_id: session[:usuario_id]).take
          session[:plan_id] = @planformacion.id
	      end
	      if params[:informe_id]!=nil
	        session[:informe_id]= params[:informe_id]
	      end
        if !session[:informe_id].blank?
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
          flash[:info]="Selecciona un informe"
          redirect_to controller: "inicioinstructor", action: "listar_informes"
        end
	    else
	      redirect_to controller:"forminst", action: "index"
	    end
	end

	def detalles_informe2
    if !session[:informe_id].blank?
      @nombre = session[:nombre_usuario]   
        if not @nombre
          print "NO HAY USUARIO"
        end
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
      @resultados2= ""
      @resultados2a= []
      @resultados2b= []
      @actividadese= []
      @observaciont= []
      @actividadesa.each do |actade| 
        if actade.actividad_id == nil #Es el caso que es un resultado no contemplado en el plan de formacion o un avancwe de postgrado
          if @resultados2b != []
            @resultados2b= Array.new(0) { |i|  }
          end
          @res= Resultado.where(informe_actividad_id: actade.id).all
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
          @resultados2a.push(@resultados2b)
        else
          @act= Actividad.find(actade.actividad_id)
          tipo= @act.tipo_actividad_id
          if @resultados2b != []
            @resultados2b= Array.new(0) { |i|  }
          end
          @res= Resultado.where(informe_actividad_id: actade.id).all
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
          @resultados2a.push(@resultados2b)
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
    else
          flash[:info]="Selecciona un informe"
          redirect_to controller: "inicioinstructor", action: "listar_informes"
    end
  end

  def borrar_notificaciones #mas obs de actividades del informe
    if session[:usuario_id] && session[:instructor]= true
      @noti= params[:noti]
      notaeliminar = Notificacion.where(id: @noti ).take
      if notaeliminar.blank?
          flash[:danger] = "Ha ocurrido un error al eliminar (notificacion no existente)"
      else
        notaeliminar.destroy
      end
      redirect_to controller:"inicioinstructor", action: "index"
    else
      redirect_to controller:"forminst", action: "index"
    end
  end

end