class AdecuacionsController < ApplicationController

  def generar_pdf(adecuacion) # es función permite generar el documento pdf de la adecuación
    @adecuacion= Adecuacion.find(adecuacion) # se obtienen la información de la adecuación seleccionada
    @planformacion= Planformacion.find(@adecuacion.planformacion_id)
    @id_docente= @planformacion.tutor_id # se obtiene el indicador del ususario al que corresponde la adecuación
    @usertutor= Usuario.find(@id_docente) # se obtiene la información del tutor mediante la base de datos y la variable anterior
    @tutor= Persona.where(usuario_id: @id_docente).take
    @id_instructor= @planformacion.instructor_id # se toma el identificador del instructor
    @userinst=Usuario.find(@id_instructor) # se obtienen toda la información del instructor 
    @instructor= Persona.where(usuario_id: @id_instructor).take
    @userentidad= Usuarioentidad.where(usuario_id: @planformacion.instructor_id).take
      if @userentidad.escuela_id == nil
        @userentidad.escuela_id=12
        @userentidad.save
        @escuela= Escuela.where(id: @userentidad.escuela_id).take
      else
        @escuela= Escuela.where(id: @userentidad.escuela_id).take
      end


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

    @actividadesa= AdecuacionActividad.where(adecuacion_id: @adecuacion.id, semestre: 1).all
    @actividadesa.each do |actade| 
      @act= Actividad.find(actade.actividad_id)
      tipo= @act.tipo_actividad_id
      if tipo==1
        puts "soy una actividad de docencia"
        puts @act.actividad
        @pactv_docencia.push(@act)
      else
        if tipo==2
          puts "soy una actividad de investigacion"
          puts @act.actividad
          @pactv_investigacion.push(@act)
        else
          if tipo==3
            puts "soy una actividad de extension"
            puts @act.actividad
            @pactv_extension.push(@act)
          else
            if tipo==4
              puts "soy una actividad de formacion"
              puts @act.actividad
              @pactv_formacion.push(@act)
            else
              if tipo==5
                puts "soy otro tipo de actividad"
                puts @act.actividad
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
        @sactv_docencia.push(@act)
      else
        if tipo==2
          puts "soy una actividad de investigacion"
          puts @act.actividad
          @sactv_investigacion.push(@act)
        else
          if tipo==3
            puts "soy una actividad de extension"
            puts @act.actividad
            @sactv_extension.push(@act)
          else
            if tipo==4
              puts "soy una actividad de formacion"
              puts @act.actividad
              @sactv_formacion.push(@act)
            else
              if tipo==5
                puts "soy otro tipo de actividad"
                puts @act.actividad
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
        @tactv_docencia.push(@act)
      else
        if tipo==2
          puts "soy una actividad de investigacion"
          puts @act.actividad
          @tactv_investigacion.push(@act)
        else
          if tipo==3
            puts "soy una actividad de extension"
            puts @act.actividad
            @tactv_extension.push(@act)
          else
            if tipo==4
              puts "soy una actividad de formacion"
              puts @act.actividad
              @tactv_formacion.push(@act)
            else
              if tipo==5
                puts "soy otro tipo de actividad"
                puts @act.actividad
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
        @cactv_docencia.push(@act)
      else
        if tipo==2
          puts "soy una actividad de investigacion"
          puts @act.actividad
          @cactv_investigacion.push(@act)
        else
          if tipo==3
            puts "soy una actividad de extension"
            puts @act.actividad
            @cactv_extension.push(@act)
          else
            if tipo==4
              puts "soy una actividad de formacion"
              puts @act.actividad
              @cactv_formacion.push(@act)
            else
              if tipo==5
                puts "soy otro tipo de actividad"
                puts @act.actividad
                @cactv_otras.push(@act)
              end
            end
          end
        end
      end
    end

    # se llama a la función de "pedf_adecuacion" del modelo "pdf", pasando todas las variables correspondientes
    Pdf.pdf_adecuacion(@planformacion, @adecuacion, @tutor, @instructor, @correoi, @escuela, @pactv_docencia, @pactv_investigacion, @pactv_extension, @pactv_formacion, @pactv_otras, @sactv_docencia, @sactv_investigacion, @sactv_extension, @sactv_formacion, @sactv_otras, @tactv_docencia, @tactv_investigacion, @tactv_extension, @tactv_formacion, @tactv_otras, @cactv_docencia, @cactv_investigacion, @cactv_extension, @cactv_formacion, @cactv_otras)
    @nombre_archivo= @instructor.ci.to_s+'-'+@adecuacion.fecha_creacion.to_s+'-adecuacion.pdf' # se arma el nombre del documento 

    return @nombre_archivo # se retorna el nombre del archivo
  end

####################################################################################  
  def descargar_pdf # esta función permite la generación y descarga del archivo PDF del documento
    puts "entre a descargar"
    pdf = Prawn::Document.new

    # From: Example Docs (http://prawn.majesticseacreature.com/manual.pdf)
    # The document grid on Prawn is just a table-like structure with a defined number of rows and columns. 
    # There are some helpers to create boxes of content based on the grid coordinates.
    # define_grid accepts the following options: 
    #  :rows          - Number of rows in the grid 
    #  :columns       - Number of columns in the grid
    #  :gutter        - Padding of each cell
    #  :row_gutter    - Padding between rows
    #  :column_gutter - Padding between columns

    pdf.define_grid(:columns => 6, :rows => 8, :gutter => 10)

    # Helper method to showcase the positioning of all grid cells
    pdf.grid.show_all
    
    # New blank canvas for another example
    pdf.start_new_page
    
    # The grid only need to be defined once, but since all the examples should be
    # able to run alone we are repeating it on every example
    pdf.grid([2,2], [4,4]).bounding_box do
      pdf.move_down 100
      pdf.text "We can write text inside grid elements or any other shape"
    end

    # to help visualize the grid position, show the outline
    pdf.grid([2,2],[4,4]).show

    # Sends the PDF as inline document with name x.pdf
    send_data pdf.render, :filename => "x.pdf", :type => "application/pdf", :disposition => 'inline'
    flash[:success] = "El archivo se ha creado correctamente." #se muestra un mensaje de exito
  end

end
