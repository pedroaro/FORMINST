class InformesController < ApplicationController
  layout 'ly_inicio_tutor'
  
  def ver_crear_informe
    @ejecutada = 'ejecutada'
    @observacion = 'observacion'
    
    if session[:usuario_id]
      @informes= Informe.where(planformacion_id: session[:plan_id],numero: params[:informe_id]).take
      if !@informes.blank?
        flash[:danger]= "Este informe ya fue creado"
        redirect_to controller:"informes", action: "listar_informes"
      else
        if session[:adecuacion_id]
          @adecuacion= Adecuacion.find(session[:adecuacion_id])
          esta = EstatusAdecuacion.where(adecuacion_id: session[:adecuacion_id], actual: 1).take
          puts "crear informe"
          puts esta.estatus_id
          if esta.estatus_id == 6 
            flash[:warning]= "La adecuación debe ser enviada/aproabada para poder crear algun informe"
            redirect_to controller:"iniciotutor", action: "listar_adecuaciones"
          end
          @actividadesa= []
          @actividadesadoc= []
          @actividadesainv= []
          @actividadesaext= []
          @actividadesafor= []
          @actividadesaotr= []
          if params[:informe_id].to_i == 1
            @nombre_informe = "PRIMER SEMESTRAL"
            @tipo_informe=1 
            @numero_informe=1
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
          else
            if params[:informe_id].to_i ==2
              @nombre_informe = "SEGUNDO SEMESTRAL"
              @tipo_informe=2
              @numero_informe=2
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
            else
              if params[:informe_id].to_i ==3
                @nombre_informe = "PRIMER ANUAL"
                @tipo_informe=3
                @numero_informe=3
                @actividadesa= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: [1,2]).all
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
              else
                if params[:informe_id].to_i ==4
                  @nombre_informe = "TERCER SEMESTRAL"
                  @tipo_informe=4
                  @numero_informe=4
                  @actividadesa= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: 3).all
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
                else
                  if params[:informe_id].to_i ==5
                    @nombre_informe = "CUARTO SEMESTRAL"
                    @tipo_informe=5
                    @numero_informe=5
                    @actividadesa= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: 4).all
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
                  else
                    if params[:informe_id].to_i ==6
                      @nombre_informe = "SEGUNDO ANUAL"
                      @tipo_informe=6
                      @numero_informe=6
                      @actividadesa= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: [3,4]).all
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
                    else
                      if params[:informe_id].to_i ==7
                        @nombre_informe = "PRIMER FINAL"
                        @tipo_informe=7
                        @numero_informe=7
                        @actividadesa= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: [1,2,3,4]).all
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
                      else
                        flash[:danger]= "Ya completo el numero de informes, no puede crear más"
                        redirect_to controller:"informes", action: "listar_informes"
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
        else
          flash[:warning]= "Seleccione una adecuación para que pueda crear un informe"
          redirect_to controller:"iniciotutor", action: "listar_adecuaciones"
        end
      end
    else
      redirect_to controller:"forminst", action: "index"
    end
  end

  def eliminar_informe
    @informe= Informe.find(session[:informe_id])
    @est= EstatusInforme.where(informe_id: @informe.id, actual: 1).take
    if @est.estatus_id == 6
      @informe.destroy
      flash[:success]= "El informe fue eliminado correctamente"
    else
      flash[:danger]= "No está permitido eliminar este informe"
    end
    redirect_to controller:"informes", action: "listar_informes"
  end

  def detalles_informe2
    if session[:usuario_id]
      @nombre = session[:nombre_usuario]   
      if not @nombre
        print "NO HAY USUARIO"
      end
      @persona = Persona.where(usuario_id: session[:usuario_id]).take
      if session[:plan_id]
        puts "HAY SESION PLAN"
        @planformacion = Planformacion.find(session[:plan_id])
      else
        puts "NO HAY SESION PLAN"
        @planformacion = Planformacion.find(session[:plan_id])
      end
    @informe= Informe.find(session[:informe_id])
    @estatus= EstatusInforme.where(informe_id: @informe.id, actual: 1).take
    @status= TipoEstatus.find(@estatus.estatus_id)
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

    @bool_enviado = 0
    estatus_informe = EstatusInforme.where(informe_id: @informe.id, actual: 1).take


    if (estatus_informe.estatus_id != 6 && estatus_informe.estatus_id != 5)
      @bool_enviado = 1
    end

    @mes = ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre']
    @dia= [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]
    @tipos= [['Libros',1], ['Artículo de Revista',2], ['Artículo de Prensa',3], ['CD',4], ['Manuales',5], ['Publicaciones Electrónicas',6]]
    else
     redirect_to controller:"forminst", action: "index"
    end
  end

def vista_previa
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
    @tutor = Persona.where(usuario_id: session[:usuario_id]).take

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
            if !(@resActi.resultado_id).blank?
              puts @resActi.id
              @res= Resultado.find(@resActi.resultado_id)
            end
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
      if actade.actividad_id == nil #Es el caso que es un resultado no contemplado en el plan de formacion o un avancwe de postgrado
        @res= Resultado.find(actade.resultado_id)
        if !@res.blank?
          @cparray = ["a", "a", "a", "a", "a", "a", "a", "a", "a","a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a"]
          @cparray[0] = @res.titulo.capitalize
          @cparray[1] = @res.autor.capitalize
          @cparray[2] = @res.titulo_capitulo.to_s.capitalize
          @cparray[3] = @res.autor_capitulo.to_s.capitalize
          @cparray[4] = @res.dia
          @cparray[5] = @res.mes
          @cparray[6] = @res.ano
          @cparray[7] = @res.ciudad.to_s.capitalize
          @cparray[8] = @res.estado.to_s.capitalize
          @cparray[9] = @res.pais.to_s.capitalize
          @cparray[10] = @res.organizador.to_s.capitalize
          @cparray[11] = @res.duracion
          @cparray[12] = @res.editor.to_s.capitalize
          @cparray[13] = @res.titulo_libro.to_s.capitalize
          @cparray[14] = @res.autor_libro.to_s.capitalize
          @cparray[15] = @res.nombre_revista.to_s.capitalize
          @cparray[16] = @res.nombre_periodico.to_s.capitalize
          @cparray[17] = @res.nombre_acto.to_s.capitalize
          @cparray[18] = @res.paginas
          @cparray[19] = @res.nombre_paginaw
          @cparray[20] = @res.sitio_paginaw
          @cparray[21] = @res.url.to_s.capitalize
          @cparray[22] = @res.ISSN_impreso.to_s.capitalize
          @cparray[23] = @res.ISSN_electro.to_s.capitalize
          @cparray[24] = @res.volumen.to_s.capitalize
          @cparray[25] = @res.edicion.to_s.capitalize
          @cparray[26] = @res.DOI
          @cparray[27] = @res.ISBN
          @cparray[28] = @res.universidad.to_s.capitalize
          @cparray[29] = @res.MaeDoc.to_s.capitalize
          @cparray[30] = @res.rango_paginas.to_s.capitalize
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
        end
        if @res.tipo_resultado_id == 1
        @resultTP.push(@resultados2)
        elsif @res.tipo_resultado_id == 2
        @resultPP.push(@resultados2)
        elsif @res.tipo_resultado_id == 3
        @resultPIT.push(@resultados2)
        elsif @res.tipo_resultado_id == 4
        @resultO.push(@resultados2)
        elsif @res.tipo_resultado_id == 5
        @resultAEC.push(@resultados2)
        elsif @res.tipo_resultado_id == 6
        @resultOEC.push(@resultados2)
        elsif @res.tipo_resultado_id == 7
        @resultDCS.push(@resultados2)
        end
        @resultados.push(@res)
      else
        @act= Actividad.find(actade.actividad_id)
        tipo= @act.tipo_actividad_id
        if actade.resultado_id
          @res= Resultado.find(actade.resultado_id)
        if !@res.blank?
          @cparray = ["a", "a", "a", "a", "a", "a", "a", "a", "a","a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a"]
          @cparray[0] = @res.titulo.capitalize
          @cparray[1] = @res.autor.capitalize
          @cparray[2] = @res.titulo_capitulo.to_s.capitalize
          @cparray[3] = @res.autor_capitulo.to_s.capitalize
          @cparray[4] = @res.dia
          @cparray[5] = @res.mes
          @cparray[6] = @res.ano
          @cparray[7] = @res.ciudad.to_s.capitalize
          @cparray[8] = @res.estado.to_s.capitalize
          @cparray[9] = @res.pais.to_s.capitalize
          @cparray[10] = @res.organizador.to_s.capitalize
          @cparray[11] = @res.duracion
          @cparray[12] = @res.editor.to_s.capitalize
          @cparray[13] = @res.titulo_libro.to_s.capitalize
          @cparray[14] = @res.autor_libro.to_s.capitalize
          @cparray[15] = @res.nombre_revista.to_s.capitalize
          @cparray[16] = @res.nombre_periodico.to_s.capitalize
          @cparray[17] = @res.nombre_acto.to_s.capitalize
          @cparray[18] = @res.paginas
          @cparray[19] = @res.nombre_paginaw
          @cparray[20] = @res.sitio_paginaw
          @cparray[21] = @res.url.to_s.capitalize
          @cparray[22] = @res.ISSN_impreso.to_s.capitalize
          @cparray[23] = @res.ISSN_electro.to_s.capitalize
          @cparray[24] = @res.volumen.to_s.capitalize
          @cparray[25] = @res.edicion.to_s.capitalize
          @cparray[26] = @res.DOI
          @cparray[27] = @res.ISBN
          @cparray[28] = @res.universidad.to_s.capitalize
          @cparray[29] = @res.MaeDoc.to_s.capitalize
          @cparray[30] = @res.rango_paginas.to_s.capitalize
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
        end
        if @res.tipo_resultado_id == 1
        @resultTP.push(@resultados2)
        elsif @res.tipo_resultado_id == 2
        @resultPP.push(@resultados2)
        elsif @res.tipo_resultado_id == 3
        @resultPIT.push(@resultados2)
        elsif @res.tipo_resultado_id == 4
        @resultO.push(@resultados2)
        elsif @res.tipo_resultado_id == 5
        @resultAEC.push(@resultados2)
        elsif @res.tipo_resultado_id == 6
        @resultOEC.push(@resultados2)
        elsif @res.tipo_resultado_id == 7
        @resultDCS.push(@resultados2)
        end
        @resultados.push(@res)
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
        @planformacion = Planformacion.find(session[:plan_id])
      else
        puts "NO HAY SESION PLAN"
        @planformacion = Planformacion.find(session[:plan_id])
      end

      if params[:informe_id]
        puts "HAY SESION PLAN"
        session[:informe_id] = params[:informe_id]
      end
      puts "Informe"
      puts session[:informe_id]

      @instructor = Persona.where(usuario_id: @planformacion.instructor_id).take
      @informe= Informe.find(session[:informe_id])
      @estatus= EstatusInforme.where(informe_id: @informe.id, actual: 1).take
      @status= TipoEstatus.find(@estatus.estatus_id)
      if @informe.numero == 1
        @nombre_informe= "PRIMER INFORME "
        session[:numero_informe]=1
      else
        if @informe.numero == 2
          @nombre_informe= "SEGUNDO INFORME "
          session[:numero_informe]=2
        else
          if @informe.numero == 4
            @nombre_informe= "TERCER INFORME "
            session[:numero_informe]=4
          else                                                                                                                                                                                                                                                                    
            @nombre_informe= "CUARTO INFORME "
            session[:numero_informe]=5
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

  
      @userentidad= Usuarioentidad.where(usuario_id: @planformacion.instructor_id).take
      @entidad= Entidad.find(@userentidad.entidad_id)
      puts "entidaaaaaaaaaad"
      puts @entidad
      @escuela= Escuela.find(@userentidad.escuela_id)
      session[:nombre_informe] = @nombre_informe
      session[:status_informe] = @status.concepto

      @bool_enviado = 0
      estatus_informe = EstatusInforme.where(informe_id: @informe.id, actual: 1).take

      if (estatus_informe.estatus_id != 6 && estatus_informe.estatus_id != 5)
        @bool_enviado = 1
      end
    else
      redirect_to controller:"forminst", action: "index"
    end
  end

  def crear_informe

    if session[:usuario_id]
      nombre = session[:nombre_usuario]   
      if not @nombre
        print "NO HAY USUARIO"
      end
      @persona = Persona.where(usuario_id: session[:usuario_id]).take

      if session[:plan_id]
        puts "HAY SESION PLAN"
        @planformacion = Planformacion.find(session[:plan_id])
      else
        puts "NO HAY SESION PLAN"
        @planformacion = Planformacion.find(session[:plan_id])
      end
      @cant_doc= params[:cant_docencia].to_i
      @cant_inv= params[:cant_investigacion].to_i
      @cant_for= params[:cant_formacion].to_i
      @cant_ext= params[:cant_extension].to_i
      @cant_otr= params[:cant_otra].to_i

      @tipo_informe = params[:tipoinf].to_i
      @numero_informe= params[:numero_informe].to_i
      if @tipo_informe == 1 || @tipo_informe==2 || @tipo_informe==4 || @tipo_informe==5
        @tipo= 1
        @nombre_inf= 'Semestral'
      else
        if @tipo_informe== 3 || @tipo_informe==6
          @tipo=2
          @nombre_inf= 'Anual'
        else
          @tipo=3
          @nombre_inf= 'Final'
        end
      end
      informe = Informe.new
      informe.planformacion_id = session[:plan_id]
      informe.tutor_id = session[:usuario_id]
      informe.opinion_tutor = params[:opinion]
      informe.conclusiones = params[:conclusiones]
      informe.tipo_id = @tipo
      informe.numero = @numero_informe
      informe.fecha_creacion = Time.now
      informe.fecha_modificacion = Time.now
      
      informe.save
      puts "Se guarda informe"

      ei = EstatusInforme.new
      ei.informe_id = informe.id
      ei.fecha = Time.now
      ei.estatus_id = 6
      ei.actual = 1
      ei.save
      puts "Se guarda estatus"
      

      @estado =EstatusInforme.where(informe_id: informe.id, actual: 1).take
      puts @estado
      informe.estado = @estado.id
      informe.save
      puts "Se guarda el estatus en el informe"


      #Comienza actividades de docencia
      j=0
      i=:doc.to_s+j.to_s
      @act = params[i].to_i
      while j <  @cant_doc
        ia = InformeActividad.new
        ia.informe_id = informe.id
        ia.actividad_id = @act
        ia.save

        ejecutada =:ejecutada.to_s+@act.to_s
        if params[ejecutada]!=nil && params[ejecutada]!=""
          ae = ActividadEjecutada.new
          ae.descripcion = params[ejecutada]
          ae.fecha = Time.now
          ae.actual = 1
          ae.informe_actividad_id = ia.id
          ae.save
        end

        observacion =:observacion.to_s+@act.to_s
        if params[observacion]!=nil && params[observacion]!=""
          oa = ObservacionTutor.new
          oa.observaciones = params[observacion]
          oa.fecha = Time.now
          oa.actual = 1
          oa.informe_actividad_id = ia.id
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
      while j <  @cant_inv
        ia = InformeActividad.new
        ia.informe_id = informe.id
        ia.actividad_id = @act
        ia.save

        ejecutada =:ejecutada.to_s+@act.to_s
        if params[ejecutada]!=nil && params[ejecutada]!=""
          ae = ActividadEjecutada.new
          ae.descripcion = params[ejecutada]
          ae.fecha = Time.now
          ae.actual = 1
          ae.informe_actividad_id = ia.id
          ae.save
        end

        observacion =:observacion.to_s+@act.to_s
        if params[observacion]!=nil && params[observacion]!=""
          oa = ObservacionTutor.new
          oa.observaciones = params[observacion]
          oa.fecha = Time.now
          oa.actual = 1
          oa.informe_actividad_id = ia.id
          oa.save
        end
        
        #Guardo los resultados de la actividad

        @tipo = params[:tipo.to_s+j.to_s].to_i
        puts @tipo
        @tipo_publicacion = params[:tipo_publicacion.to_s+j.to_s].to_i
        puts @tipo_publicacion
        @titulo = params[:titulo.to_s+j.to_s]
        puts @titulo
        @autor = params[:autor.to_s+j.to_s]
        puts @autor
        @nombre_capitulo = params[:nombre_capitulo.to_s+j.to_s]
        puts @nombre_capitulo
        @autor_capitulo = params[:autor_capitulo.to_s+j.to_s]
        puts @autor_capitulo
        @dia = params[:dia.to_s+j.to_s].to_i
        puts @dia
        @mes = params[:mes.to_s+j.to_s]
        puts @mes
        @ano = params[:ano.to_s+j.to_s].to_i
        puts @ano
        @ciudad = params[:ciudad.to_s+j.to_s]
        puts @ciudad
        @estado = params[:estado.to_s+j.to_s]
        puts @estado
        @pais = params[:pais.to_s+j.to_s]
        puts @pais
        @organizador = params[:organizador.to_s+j.to_s]
        puts @organizador
        @duracion = params[:duracion.to_s+j.to_s]
        puts @duracion
        @editor = params[:editor.to_s+j.to_s]
        puts @editor
        @titulo_libro = params[:titulo_libro.to_s+j.to_s]
        puts @titulo_libro
        @autor_libro = params[:autor_libro.to_s+j.to_s]
        puts @autor_libro
        @nombre_revista = params[:nombre_revista.to_s+j.to_s]
        puts @nombre_revista
        @nombre_periodico = params[:nombre_periodico.to_s+j.to_s]
        puts @nombre_periodico
        @paginas = params[:paginas.to_s+j.to_s]
        puts @paginas
        @nombre_acto = params[:nombre_acto.to_s+j.to_s]
        puts @nombre_acto
        @nombre_paginaw = params[:nombre_paginaw.to_s+j.to_s]
        puts @nombre_paginaw
        @sitio_paginaw = params[:sitio_paginaw.to_s+j.to_s]
        puts @sitio_paginaw
        @url = params[:url.to_s+j.to_s]
        puts @url

        if @tipo!=nil && @tipo!="" && @tipo!=0
          r = Resultado.new 
          r.tipo_resultado_id = @tipo

          if @tipo == 1
            r.tipo_publicacion = @tipo_publicacion
          end

          if @titulo!=nil && @titulo!=""
            r.titulo = @titulo
          end

          if @autor!=nil && @autor!=""
            r.autor = @autor
          end

          if @nombre_capitulo!=nil &&  @nombre_capitulo!=""
            r.titulo_capitulo = @nombre_capitulo
          end

          if @autor_capitulo!=nil && @autor_capitulo!=""
            r.autor_capitulo = @autor_capitulo
          end

          if @dia!=nil &&  @dia!=""
            r.dia = @dia
          end

          if @mes!=nil && @mes!=""
            r.mes =@mes
          end

          if @ano!=nil && @ano!=""
            r.ano = @ano
          end

          if @ciudad!=nil && @ciudad!=""
            r.ciudad = @ciudad
          end

          if @estado!=nil && @estado!=""
            r.estado = @estado
          end

          if @pais!=nil && @pais!=""
            r.pais = @pais
          end

          if @organizador!=nil && @organizador!=""
            r.organizador = @organizador
          end

          if @duracion!=nil && @duracion!=""
            r.duracion = @duracion
          end

          if @editor!=nil && @editor!=""
            r.editor = @editor
          end

          if @titulo_libro!=nil && @titulo_libro!=""
            r.titulo_libro = @titulo_libro
          end

          if @autor_libro!=nil && @autor_libro!=""
            r.autor_libro = @autor_libro
          end

          if @nombre_revista!=nil && @nombre_revista!=""
            r.nombre_revista = @nombre_revista
          end

          if @nombre_periodico!=nil && @nombre_periodico!=""
            r.nombre_periodico = @nombre_periodico
          end

          if @paginas!=nil && @paginas!=""
            r.paginas = @paginas
          end

          if @nombre_acto!=nil && @nombre_acto!=""
            r.nombre_acto = @nombre_acto
          end

          if @nombre_paginaw!=nil && @nombre_paginaw!=""
            r.nombre_paginaw = @nombre_paginaw
          end

          if @sitio_paginaw!=nil && @sitio_paginaw!=""
            r.sitio_paginaw = @sitio_paginaw
          end

          if @url!=nil && @url!=""
            r.url = @url
          end
         
          r.save
          ia.resultado_id = r.id 
          ia.save
        end



        j= j+1
        i=:inv.to_s+j.to_s
        @act= params[i].to_i
      end





      #Comienza actividades de formacion
      j=0
      i=:for.to_s+j.to_s
      @act = params[i].to_i
      while j <  @cant_for
        ia = InformeActividad.new
        ia.informe_id = informe.id
        ia.actividad_id = @act
        ia.save

        ejecutada =:ejecutada.to_s+@act.to_s
        if params[ejecutada]!=nil && params[ejecutada]!=""
          ae = ActividadEjecutada.new
          ae.descripcion = params[ejecutada]
          ae.fecha = Time.now
          ae.actual = 1
          ae.informe_actividad_id = ia.id
          ae.save
        end

        observacion =:observacion.to_s+@act.to_s
        if params[observacion]!=nil && params[observacion]!=""
          oa = ObservacionTutor.new
          oa.observaciones = params[observacion]
          oa.fecha = Time.now
          oa.actual = 1
          oa.informe_actividad_id = ia.id
          oa.save
        end

        j= j+1
        i=:for.to_s+j.to_s
        @act= params[i].to_i
      end

      if params[:postgrado]!=nil && params[:postgrado]!=""
        rp = Resultado.new
        rp.tipo_resultado_id = 8
        rp.concepto = params[:postgrado]
        rp.save
        ia = InformeActividad.new
        ia.informe_id = informe.id
        ia.resultado_id = rp.id
        ia.save
      end

      #Comienza actividades de extension
      j=0
      i=:ext.to_s+j.to_s
      @act = params[i].to_i
      while j <  @cant_ext
        ia = InformeActividad.new
        ia.informe_id = informe.id
        ia.actividad_id = @act
        ia.save

        ejecutada =:ejecutada.to_s+@act.to_s
        if params[ejecutada]!=nil && params[ejecutada]!=""
          ae = ActividadEjecutada.new
          ae.descripcion = params[ejecutada]
          ae.fecha = Time.now
          ae.actual = 1
          ae.informe_actividad_id = ia.id
          ae.save
        end

        observacion =:observacion.to_s+@act.to_s
        if params[observacion]!=nil && params[observacion]!=""
          oa = ObservacionTutor.new
          oa.observaciones = params[observacion]
          oa.fecha = Time.now
          oa.actual = 1
          oa.informe_actividad_id = ia.id
          oa.save
        end

        j= j+1
        i=:ext.to_s+j.to_s
        @act= params[i].to_i
      end

      #Comienzan otras actividades contempladas en el plan
      j=0
      i=:otra.to_s+j.to_s
      @act = params[i].to_i
      while j <  @cant_otr
        ia = InformeActividad.new
        ia.informe_id = informe.id
        ia.actividad_id = @act
        ia.save
        ejecutada =:ejecutada.to_s+@act.to_s
        if params[ejecutada]!=nil && params[ejecutada]!=""
          ae = ActividadEjecutada.new
          ae.descripcion = params[ejecutada]
          ae.fecha = Time.now
          ae.actual = 1
          ae.informe_actividad_id = ia.id
          ae.save
        end
        j= j+1
        i=:otra.to_s+j.to_s
        @act= params[i].to_i
      end

      redirect_to controller:"informes", action: "listar_informes"
      flash[:success]= "El informe fue creado y guardado correctamente"
    else
      redirect_to controller:"forminst", action: "index"
    end
  end

def generar_pdf() # es función permite generar el documento pdf de la adecuación
    if session[:plan_id] == nil
      redirect_to controller:"informes", action: "listar_informes"
      flash[:danger]= "Ha ocurrido un error"
    end
    @informe= Informe.find(session[:informe_id])
    @TipoSemestre =TipoInforme.where(id: @informe.tipo_id).take
    @planformacion = Planformacion.find(session[:plan_id])
    @adecuacion = Adecuacion.where(planformacion_id: session[:plan_id]).take
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

    @res = []
    @resActi = []
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

    @aactv_docencia= []
    @aactv_investigacion= []
    @aactv_formacion= []
    @aactv_extension=[]
    @aactv_otras=[]

    @actividadesa= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: 1).all
    @actividadesa.each do |actade| 
      @act= Actividad.find(actade.actividad_id)
      tipo= @act.tipo_actividad_id
      if tipo==1
        puts "soy una actividad de docencia"
        puts @act.actividad
        if @informe.numero == 1
          @aactv_docencia.push(@act)
        end
        @pactv_docencia.push(@act)
      else
        if tipo==2
          puts "soy una actividad de investigacion"
          puts @act.actividad
          if @informe.numero == 1
            @resActi= InformeActividad.where(informe_id: @informe.id, actividad_id: @act.id).take
            puts "HELLOOOOO"
            if !(@resActi.resultado_id).blank?
              puts @resActi.id
              @res= Resultado.find(@resActi.resultado_id)
            end
            @aactv_investigacion.push(@act)
          end
          @pactv_investigacion.push(@act)
        else
          if tipo==3
            puts "soy una actividad de extension"
            puts @act.actividad
            if @informe.numero == 1
              @aactv_formacion.push(@act)
            end
            @pactv_extension.push(@act)
          else
            if tipo==4
              puts "soy una actividad de formacion"
              puts @act.actividad
              if @informe.numero == 1
                @aactv_extension.push(@act)
              end
              @pactv_formacion.push(@act)
            else
              if tipo==5
                puts "soy otro tipo de actividad"
                puts @act.actividad
                if @informe.numero == 1
                  @aactv_otras.push(@act)
                end
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
        puts "soy una actividad de docencia"
        puts @act.actividad
        if @informe.numero == 2
          @aactv_docencia.push(@act)
        end
        @sactv_docencia.push(@act)
      else
        if tipo==2
          puts "soy una actividad de investigacion"
          puts @act.actividad
          if @informe.numero == 2
            puts "HELLaOOOOO"
            puts @informe.id
            puts "HELLaOOOOO111"
            puts @act.id
            @resActi= InformeActividad.where(informe_id: @informe.id, actividad_id: @act.id).take
            puts "HELLOOOOO"
            if !(@resActi.resultado_id).blank?
              puts @resActi.id
              puts @resActi.resultado_id
              @res= Resultado.find(@resActi.resultado_id)
            end
            @aactv_investigacion.push(@act)
          end
          @sactv_investigacion.push(@act)
        else
          if tipo==3
            puts "soy una actividad de extension"
            puts @act.actividad
            if @informe.numero == 2
              @aactv_formacion.push(@act)
            end
            @sactv_extension.push(@act)
          else
            if tipo==4
              puts "soy una actividad de formacion"
              puts @act.actividad
              if @informe.numero == 2
                @aactv_extension.push(@act)
              end
              @sactv_formacion.push(@act)
            else
              if tipo==5
                puts "soy otro tipo de actividad"
                puts @act.actividad
                if @informe.numero == 2
                  @aactv_otras.push(@act)
                end
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
        puts "soy una actividad de docencia"
        puts @act.actividad
        if @informe.numero == 4
          @aactv_docencia.push(@act)
        end
        @tactv_docencia.push(@act)
      else
        if tipo==2
          puts "soy una actividad de investigacion"
          puts @act.actividad
          if @informe.numero == 4
            @resActi= InformeActividad.where(informe_id: @informe.id, actividad_id: @act.id).take
            if !(@resActi.resultado_id).blank?
              puts @resActi.id
              @res= Resultado.find(@resActi.resultado_id)
            end
            @aactv_investigacion.push(@act)
          end
          @tactv_investigacion.push(@act)
        else
          if tipo==3
            puts "soy una actividad de extension"
            puts @act.actividad
            if @informe.numero == 4
              @aactv_formacion.push(@act)
            end
            @tactv_extension.push(@act)
          else
            if tipo==4
              puts "soy una actividad de formacion"
              puts @act.actividad
              if @informe.numero == 4
                @aactv_extension.push(@act)
              end
              @tactv_formacion.push(@act)
            else
              if tipo==5
                puts "soy otro tipo de actividad"
                puts @act.actividad
                if @informe.numero == 4
                  @aactv_otras.push(@act)
                end
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
        puts "soy una actividad de docencia"
        puts @act.actividad
        if @informe.numero == 5
          @aactv_docencia.push(@act)
        end
        @cactv_docencia.push(@act)
      else
        if tipo==2
          puts "soy una actividad de investigacion"
          puts @act.actividad
          if @informe.numero == 5
            @resActi= InformeActividad.where(informe_id: @informe.id, actividad_id: @act.id).take
            if !(@resActi.resultado_id).blank?
              puts @resActi.id
              @res= Resultado.find(@resActi.resultado_id)
            puts "holaaaaaaaaaaaaaa"
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
                  puts @noemptyarray.join(',')
                  @resultados2 = @resultados2 + "\n" + "* " + @noemptyarray.join(',')
                  puts "b"
                  puts @resultados2
                end
              end
            end
            end
            @aactv_investigacion.push(@act)
          end
          @cactv_investigacion.push(@act)
        else
          if tipo==3
            puts "soy una actividad de extension"
            puts @act.actividad
            if @informe.numero == 5
              @aactv_formacion.push(@act)
            end
            @cactv_extension.push(@act)
          else
            if tipo==4
              puts "soy una actividad de formacion"
              puts @act.actividad
              if @informe.numero == 5
                @aactv_extension.push(@act)
              end
              @cactv_formacion.push(@act)
            else
              if tipo==5
                puts "soy otro tipo de actividad"
                puts @act.actividad
                if @informe.numero == 5
                  @aactv_otras.push(@act)
                end
                @cactv_otras.push(@act)
              end
            end
          end
        end
      end
    end
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
      if actade.actividad_id == nil #Es el caso que es un resultado no contemplado en el plan de formacion o un avancwe de postgrado
        @res= Resultado.find(actade.resultado_id)
        if !@res.blank?
          @cparray = ["a", "a", "a", "a", "a", "a", "a", "a", "a","a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a"]
          @cparray[0] = @res.titulo.capitalize
          @cparray[1] = @res.autor.capitalize
          @cparray[2] = @res.titulo_capitulo.to_s.capitalize
          @cparray[3] = @res.autor_capitulo.to_s.capitalize
          @cparray[4] = @res.dia
          @cparray[5] = @res.mes
          @cparray[6] = @res.ano
          @cparray[7] = @res.ciudad.to_s.capitalize
          @cparray[8] = @res.estado.to_s.capitalize
          @cparray[9] = @res.pais.to_s.capitalize
          @cparray[10] = @res.organizador.to_s.capitalize
          @cparray[11] = @res.duracion
          @cparray[12] = @res.editor.to_s.capitalize
          @cparray[13] = @res.titulo_libro.to_s.capitalize
          @cparray[14] = @res.autor_libro.to_s.capitalize
          @cparray[15] = @res.nombre_revista.to_s.capitalize
          @cparray[16] = @res.nombre_periodico.to_s.capitalize
          @cparray[17] = @res.nombre_acto.to_s.capitalize
          @cparray[18] = @res.paginas
          @cparray[19] = @res.nombre_paginaw
          @cparray[20] = @res.sitio_paginaw
          @cparray[21] = @res.url.to_s.capitalize
          @cparray[22] = @res.ISSN_impreso.to_s.capitalize
          @cparray[23] = @res.ISSN_electro.to_s.capitalize
          @cparray[24] = @res.volumen.to_s.capitalize
          @cparray[25] = @res.edicion.to_s.capitalize
          @cparray[26] = @res.DOI
          @cparray[27] = @res.ISBN
          @cparray[28] = @res.universidad.to_s.capitalize
          @cparray[29] = @res.MaeDoc.to_s.capitalize
          @cparray[30] = @res.rango_paginas.to_s.capitalize
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
        end
        if @res.tipo_resultado_id == 1
        @resultTP.push(@resultados2)
        elsif @res.tipo_resultado_id == 2
        @resultPP.push(@resultados2)
        elsif @res.tipo_resultado_id == 3
        @resultPIT.push(@resultados2)
        elsif @res.tipo_resultado_id == 4
        @resultO.push(@resultados2)
        elsif @res.tipo_resultado_id == 5
        @resultAEC.push(@resultados2)
        elsif @res.tipo_resultado_id == 6
        @resultOEC.push(@resultados2)
        elsif @res.tipo_resultado_id == 7
        @resultDCS.push(@resultados2)
        end
        @resultados.push(@res)
      else
        @act= Actividad.find(actade.actividad_id)
        tipo= @act.tipo_actividad_id
        if actade.resultado_id
          @res= Resultado.find(actade.resultado_id)
        if !@res.blank?
          @cparray = ["a", "a", "a", "a", "a", "a", "a", "a", "a","a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a"]
          @cparray[0] = @res.titulo.capitalize
          @cparray[1] = @res.autor.capitalize
          @cparray[2] = @res.titulo_capitulo.to_s.capitalize
          @cparray[3] = @res.autor_capitulo.to_s.capitalize
          @cparray[4] = @res.dia
          @cparray[5] = @res.mes
          @cparray[6] = @res.ano
          @cparray[7] = @res.ciudad.to_s.capitalize
          @cparray[8] = @res.estado.to_s.capitalize
          @cparray[9] = @res.pais.to_s.capitalize
          @cparray[10] = @res.organizador.to_s.capitalize
          @cparray[11] = @res.duracion
          @cparray[12] = @res.editor.to_s.capitalize
          @cparray[13] = @res.titulo_libro.to_s.capitalize
          @cparray[14] = @res.autor_libro.to_s.capitalize
          @cparray[15] = @res.nombre_revista.to_s.capitalize
          @cparray[16] = @res.nombre_periodico.to_s.capitalize
          @cparray[17] = @res.nombre_acto.to_s.capitalize
          @cparray[18] = @res.paginas
          @cparray[19] = @res.nombre_paginaw
          @cparray[20] = @res.sitio_paginaw
          @cparray[21] = @res.url.to_s.capitalize
          @cparray[22] = @res.ISSN_impreso.to_s.capitalize
          @cparray[23] = @res.ISSN_electro.to_s.capitalize
          @cparray[24] = @res.volumen.to_s.capitalize
          @cparray[25] = @res.edicion.to_s.capitalize
          @cparray[26] = @res.DOI
          @cparray[27] = @res.ISBN
          @cparray[28] = @res.universidad.to_s.capitalize
          @cparray[29] = @res.MaeDoc.to_s.capitalize
          @cparray[30] = @res.rango_paginas.to_s.capitalize
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
        end
        if @res.tipo_resultado_id == 1
        @resultTP.push(@resultados2)
        elsif @res.tipo_resultado_id == 2
        @resultPP.push(@resultados2)
        elsif @res.tipo_resultado_id == 3
        @resultPIT.push(@resultados2)
        elsif @res.tipo_resultado_id == 4
        @resultO.push(@resultados2)
        elsif @res.tipo_resultado_id == 5
        @resultAEC.push(@resultados2)
        elsif @res.tipo_resultado_id == 6
        @resultOEC.push(@resultados2)
        elsif @res.tipo_resultado_id == 7
        @resultDCS.push(@resultados2)
        end
        @resultados.push(@res)
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
    end
    
    puts "hellooooo"
    # se llama a la función de "pedf_adecuacion" del modelo "pdf", pasando todas las variables correspondientes
    Pdf.pdf_informe(@TipoSemestre, @escuela, @informe, @adecuacion, @tutor, @instructor, @pactv_docencia, @pactv_investigacion, @pactv_extension, @pactv_formacion, @pactv_otras, @sactv_docencia, @sactv_investigacion, @sactv_extension, @sactv_formacion, @sactv_otras, @tactv_docencia, @tactv_investigacion, @tactv_extension, @tactv_formacion, @tactv_otras, @cactv_docencia, @cactv_investigacion, @cactv_extension, @cactv_formacion, @cactv_otras, @actividadesadoc, @actividadesainv, @actividadesafor, @actividadesaext, @actividadesaotr,@res,@resultados,@actividadese,@observaciont,@resultTP,@resultPP,@resultO,@resultAEC,@resultOEC,@resultDCS)
    @nombre_archivo= @instructor.ci.to_s+'-'+@fechaActual+'-informe.pdf' # se arma el nombre del documento 
    puts @nombre_archivo
    act = "#{Rails.root}/" + @nombre_archivo
    send_file(
      act,
      filename: @nombre_archivo,
      type: "application/pdf"
    )
    return @nombre_archivo # se retorna el nombre del archivo
  end

  def actualizar_informe
    @informe= Informe.find(session[:informe_id])
    @informe.fecha_modificacion = Time.now
    @cant_doc= params[:cant_docencia].to_i
    @cant_inv= params[:cant_investigacion].to_i
    @cant_for= params[:cant_formacion].to_i
    @cant_ext= params[:cant_extension].to_i
    @cant_otr= params[:cant_otra].to_i
    @cant_result= params[:cant_result].to_i
    @informe.opinion_tutor = params[:opinion]
    @informe.conclusiones = params[:conclusiones]
    @plan= Planformacion.find(session[:plan_id])
    @plan.fecha_modificacion = Time.now
    @plan.save
    @informe.save
  #Comienza actividades de docencia
      j=0
      i=:doc.to_s+j.to_s
      @act = params[i].to_i
      while j <  @cant_doc
        ia = InformeActividad.where(informe_id: @informe.id,actividad_id: @act).take

        ejecutada =:ejecutada.to_s+@act.to_s
        if params[ejecutada]!=nil && params[ejecutada]!=""
          ae = ActividadEjecutada.where(informe_actividad_id: ia.id, actual: 1).take
          ae.descripcion = params[ejecutada]
          ae.save
        end

        observacion =:observacion.to_s+@act.to_s
      
          oa = ObservacionTutor.where(informe_actividad_id: ia.id).take
            if(oa == nil || oa =="")
              oa = ObservacionTutor.new
              oa.observaciones = params[observacion]
              oa.fecha = Time.now
              oa.informe_actividad_id = ia.id
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

        ejecutada =:ejecutada.to_s+@act.to_s
        if params[ejecutada]!=nil && params[ejecutada]!=""
          ae = ActividadEjecutada.where(informe_actividad_id: ia.id, actual: 1).take
          ae.descripcion = params[ejecutada]
          ae.save
        end

         observacion =:observacion.to_s+@act.to_s
       
          oa = ObservacionTutor.where(informe_actividad_id: ia.id).take
            if(oa == nil || oa =="")
              oa = ObservacionTutor.new
              oa.observaciones = params[observacion]
              oa.fecha = Time.now
              oa.informe_actividad_id = ia.id
              oa.save
            else
               oa.observaciones = params[observacion]
                  oa.save
            end
     
        

      
        

      #Actualizará los resultados

        @tipo = params[:tipo.to_s+j.to_s].to_i
        @tipo_publicacion = params[:tipo_publicacion.to_s+j.to_s].to_i
        @titulo = params[:titulo.to_s+j.to_s]
        @autor = params[:autor.to_s+j.to_s]
        @nombre_capitulo = params[:nombre_capitulo.to_s+j.to_s]
        @autor_capitulo = params[:autor_capitulo.to_s+j.to_s]
        @dia = params[:dia.to_s+j.to_s].to_i
        @mes = params[:mes.to_s+j.to_s]
        @ano = params[:ano.to_s+j.to_s].to_i
        @ciudad = params[:ciudad.to_s+j.to_s]
        @estado = params[:estado.to_s+j.to_s]
        @pais = params[:pais.to_s+j.to_s]
        @organizador = params[:organizador.to_s+j.to_s]
        @duracion = params[:duracion.to_s+j.to_s]
        @editor = params[:editor.to_s+j.to_s]
        @titulo_libro = params[:titulo_libro.to_s+j.to_s]
        @autor_libro = params[:autor_libro.to_s+j.to_s]
        @nombre_revista = params[:nombre_revista.to_s+j.to_s]
        @nombre_periodico = params[:nombre_periodico.to_s+j.to_s]
        @paginas = params[:paginas.to_s+j.to_s]
        @nombre_acto = params[:nombre_acto.to_s+j.to_s]
        @nombre_paginaw = params[:nombre_paginaw.to_s+j.to_s]
        @sitio_paginaw = params[:sitio_paginaw.to_s+j.to_s]
        @url = params[:url.to_s+j.to_s]

        if @tipo!=nil && @tipo!="" && @tipo!=0

          if @result!= -1
            r= Resultado.find(@result)
          else
            r = Resultado.new 
            r.tipo_resultado_id = @tipo
          end

          r.tipo_resultado_id = @tipo

          if @tipo == 1
            r.tipo_publicacion = @tipo_publicacion
          end

          if @titulo!=nil && @titulo!=""
            r.titulo = @titulo
          end

          if @autor!=nil && @autor!=""
            r.autor = @autor
          end

          if @nombre_capitulo!=nil &&  @nombre_capitulo!=""
            r.titulo_capitulo = @nombre_capitulo
          end

          if @autor_capitulo!=nil && @autor_capitulo!=""
            r.autor_capitulo = @autor_capitulo
          end

          if @dia!=nil &&  @dia!=""
            r.dia = @dia
          end

          if @mes!=nil && @mes!=""
            r.mes =@mes
          end

          if @ano!=nil && @ano!=""
            r.ano = @ano
          end

          if @ciudad!=nil && @ciudad!=""
            r.ciudad = @ciudad
          end

          if @estado!=nil && @estado!=""
            r.estado = @estado
          end

          if @pais!=nil && @pais!=""
            r.pais = @pais
          end

          if @organizador!=nil && @organizador!=""
            r.organizador = @organizador
          end

          if @duracion!=nil && @duracion!=""
            r.duracion = @duracion
          end

          if @editor!=nil && @editor!=""
            r.editor = @editor
          end

          if @titulo_libro!=nil && @titulo_libro!=""
            r.titulo_libro = @titulo_libro
          end

          if @autor_libro!=nil && @autor_libro!=""
            r.autor_libro = @autor_libro
          end

          if @nombre_revista!=nil && @nombre_revista!=""
            r.nombre_revista = @nombre_revista
          end

          if @nombre_periodico!=nil && @nombre_periodico!=""
            r.nombre_periodico = @nombre_periodico
          end

          if @paginas!=nil && @paginas!=""
            r.paginas = @paginas
          end

          if @nombre_acto!=nil && @nombre_acto!=""
            r.nombre_acto = @nombre_acto
          end

          if @nombre_paginaw!=nil && @nombre_paginaw!=""
            r.nombre_paginaw = @nombre_paginaw
          end

          if @sitio_paginaw!=nil && @sitio_paginaw!=""
            r.sitio_paginaw = @sitio_paginaw
          end

          if @url!=nil && @url!=""
            r.url = @url
          end
         
          r.save

          if @result== -1
            ia.resultado_id = r.id 
            ia.save
          end
        end

        j=j+1
        k=:result.to_s+j.to_s
        @result= params[k].to_i
        i=:inv.to_s+j.to_s
        @act= params[i].to_i
      end

      #Comienza actividades de formación
      j=0
      i=:for.to_s+j.to_s
      @act = params[i].to_i
      while j <  @cant_for
        ia = InformeActividad.where(informe_id: @informe.id,actividad_id: @act).take

        ejecutada =:ejecutada.to_s+@act.to_s
        if params[ejecutada]!=nil && params[ejecutada]!=""
          ae = ActividadEjecutada.where(informe_actividad_id: ia.id, actual: 1).take
          ae.descripcion = params[ejecutada]
          ae.save
        end

         observacion =:observacion.to_s+@act.to_s
      
          oa = ObservacionTutor.where(informe_actividad_id: ia.id).take
            if(oa == nil || oa =="")
              oa = ObservacionTutor.new
              oa.observaciones = params[observacion]
              oa.fecha = Time.now
              oa.informe_actividad_id = ia.id
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
       if params[:postgrado]!=nil && params[:postgrado]!=""
        if params[:postg].to_i == -1
          rp = Resultado.new
          rp.tipo_resultado_id = 8
          rp.concepto = params[:postgrado]
          rp.save
          ia = InformeActividad.new
          ia.informe_id = @informe.id
          ia.resultado_id = rp.id
          ia.save
        else
          rp= Resultado.find(params[:postg].to_i)
          rp.concepto = params[:postgrado]
          rp.save
        end
      end

      #Comienzan actividades de extensión
      j=0
      i=:ext.to_s+j.to_s
      @act = params[i].to_i
      while j <  @cant_ext
        ia = InformeActividad.where(informe_id: @informe.id,actividad_id: @act).take

        ejecutada =:ejecutada.to_s+@act.to_s
        if params[ejecutada]!=nil && params[ejecutada]!=""
          ae = ActividadEjecutada.where(informe_actividad_id: ia.id, actual: 1).take
          ae.descripcion = params[ejecutada]
          ae.save
        end

        observacion =:observacion.to_s+@act.to_s
    
          oa = ObservacionTutor.where(informe_actividad_id: ia.id).take
            if(oa == nil || oa =="")
              oa = ObservacionTutor.new
              oa.observaciones = params[observacion]
              oa.fecha = Time.now
              oa.informe_actividad_id = ia.id
              oa.save
            else
               oa.observaciones = params[observacion]
                  oa.save
            end
     
        
        
        j= j+1
        i=:ext.to_s+j.to_s
        @act= params[i].to_i
      end
      #Comienzan otras actividades
      j=0
      i=:otra.to_s+j.to_s
      @act = params[i].to_i
      while j <  @cant_otr
        ia = InformeActividad.where(informe_id: @informe.id,actividad_id: @act).take
        ejecutada =:ejecutada.to_s+@act.to_s
        if params[ejecutada]!=nil && params[ejecutada]!=""
          puts "jajajajaja"
          puts ia.id
          ae = ActividadEjecutada.where(informe_actividad_id: ia.id, actual: 1).take
          if ae.blank?
            ae = ActividadEjecutada.new
            ae.descripcion = params[ejecutada]
            ae.fecha = Time.now
            ae.actual = 1
            ae.informe_actividad_id = ia.id
            ae.save
          end
          ae.descripcion = params[ejecutada]
          ae.save
        end
        j= j+1
        i=:otra.to_s+j.to_s
        @act= params[i].to_i
      end
      #EN ESTA SECCION IRIAN LAS OTRAS ACTIVIDADES CONTEMPLADAS EN EL PLAN HAY QUE VERIFICAR SI ESTAS SE PUEDEN MODIFICAR


      flash[:success]="Su informe fue editado exitosamente"
      redirect_to controller:"informes", action: "listar_informes"

  end

  def listar_informes
    if session[:usuario_id]
      @persona = Persona.where(usuario_id: session[:usuario_id]).take
      @nombre = session[:nombre_usuario]
      @planformacion = session[:plan_id]
      @instructorName = session[:instructorName]
      @informes = Informe.where(planformacion_id: @planformacion)
      @informe = Informe.where(planformacion_id: @planformacion).take
      @status = []

      @tipos= []

      @informes.each do |inf|
        si = EstatusInforme.where(informe_id: inf.id, actual: 1).take
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


  def cambiar_estatusI
    @informe_id = params[:informe_id].to_i
    cambio_act = EstatusInforme.where(informe_id: @informe_id, actual: 1).take
    cambio_est = EstatusInforme.new 
    cambio_est.informe_id = @informe_id
    cambio_est.fecha = Time.now 
    error = 0
    informesAdecuacion = Informe.where(id: @informe_id).take
    informesAdecuaciones = Informe.where(planformacion_id: session[:plan_id]).all
    contador = 0
    if informesAdecuacion.numero != 1
      maxinforme = informesAdecuacion.numero.to_i - 1
      for i in 1..maxinforme
        informesAdecuaciones.each do |inf|
          estatusInf = EstatusInforme.where(informe_id: inf.id, actual: 1 ).take
          if (estatusInf.estatus_id != 6 && inf.numero == i)
            contador = contador + 1
          end
        end
      end
      if (contador != maxinforme)
        error = error + 1
      end
    end

    if cambio_act.estatus_id == 6 && error == 0
      cambio_est = EstatusInforme.new 
      cambio_est.informe_id = @informe_id
      cambio_est.fecha = Time.now 
      cambio_est.estatus_id = 3
      cambio_est.actual = 1
      cambio_est.save
      cambio_act.actual = 0
      cambio_act.save
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
      ActionCorreo.envio_informe(email).deliver
      flash[:success]="El informe se ha envíado a comision de investigacion"
    else
        flash[:info]="Debe enviar los informes en orden"
    end
    redirect_to controller:"informes", action: "listar_informes"
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
    
  end 

end


  