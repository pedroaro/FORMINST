class AdecuacionsController < ApplicationController

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
    @numeroDeVersion = nil
    @actividades1 = []
    actividades = AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: 0)
    if !actividades.blank?
      actividades.each do |actividadAde|
        actividad = Actividad.find(actividadAde.actividad_id)
          @actividades1.push(actividad)
      end
    end
    # se llama a la función de "pedf_adecuacion" del modelo "pdf", pasando todas las variables correspondientes
    Pdf.pdf_adecuacion(@actividades1, @planformacion, @adecuacion, @tutor, @instructor, @correoi, @correot, @escuela, @pactv_docencia, @pactv_investigacion, @pactv_extension, @pactv_formacion, @pactv_otras, @sactv_docencia, @sactv_investigacion, @sactv_extension, @sactv_formacion, @sactv_otras, @tactv_docencia, @tactv_investigacion, @tactv_extension, @tactv_formacion, @tactv_otras, @cactv_docencia, @cactv_investigacion, @cactv_extension, @cactv_formacion, @cactv_otras, @fechaActual, @fechaConcurso, @documents, @numeroDeVersion, @dactv_docencia, @dactv_investigacion, @dactv_extension, @dactv_formacion)
    @nombre_archivo= @instructor.ci.to_s+'-'+@fechaActual+'-adecuacion.pdf' # se arma el nombre del documento 
    act = "#{Rails.root}/tmp/PDFs/" + @nombre_archivo
    #act = @nombre_archivo        #PRODUCCION
    send_file(
      act,
      filename: @nombre_archivo,
      type: "application/pdf"
    )
    return @nombre_archivo # se retorna el nombre del archivo
  end

####################################################################################  
  def descargar_pdf # esta función permite la generación y descarga del archivo PDF del documento
    require 'prawn'
    pdf = Prawn::Document.new
    pdf.text "Hello It's me"
    pdf.render_file "example.pdf"
    return "example.pdf"
    #pdf_filename = File.join(Rails.root, "example.pdf")
    #send_file(pdf_filename, :filename => "example.pdf", :disposition => 'inline', :type => "application/pdf")

  end

end
