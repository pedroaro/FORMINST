class Pdf 
# estas funciones permite generar el cuerpo del documento en formato pdf

	def self.pdf_adecuacion(plan, adecuacion, tutor, instructor, correoi, correot, escuela, pactv_docencia, pactv_investigacion, pactv_extension, pactv_formacion, pactv_otras, sactv_docencia, sactv_investigacion, sactv_extension, sactv_formacion, sactv_otras, tactv_docencia, tactv_investigacion, tactv_extension, tactv_formacion, tactv_otras, cactv_docencia, cactv_investigacion, cactv_extension, cactv_formacion, cactv_otras, fechaActual, fechaConcurso, soportes,numeroDeVersion, dactv_obligatorias)
	#def self.pdf_adecuacion(adecuacion, tutor, instructor, notificacion, perfil, pactv_docencia, pactv_investigacion, pactv_extension, pactv_formacion, pactv_otras, sactv_docencia, sactv_investigacion, sactv_extension, sactv_formacion, sactv_otras, tactv_docencia, tactv_investigacion, tactv_extension, tactv_formacion, tactv_otras, cactv_docencia, cactv_investigacion, cactv_extension, cactv_formacion, cactv_otras)
		
		# se invocan la bibliotecas
		require "prawn" 
		require "prawn/layout"


		pdf= Prawn::Document.new(:background=>"#{Rails.root}/app/assets/images/fondo.png", :top_margin=> 99, :bottom_margin=>35, :page_size => 'A4') # se coloca la imagen de fondo del documento
		
		pdf.repeat :all do
			#Encabezado
			pdf.text_box "UNIVERSIDAD CENTRAL DE VENEZUELA \n FACULTAD DE CIENCIAS\n "+escuela.nombre.upcase+"\n\n",:style => :bold, :at => [pdf.bounds.right-490, pdf.bounds.top+59]
		end

		pdf.repeat :all do
			#Pie de pagina
			point = [pdf.bounds.right-525, pdf.bounds.bottom+35]
			pdf.lazy_bounding_box(point, :width => 500) do
				pdf.text " Universidad Central de Venezuela - Facultad de Ciencias \n", :size=>9 , :align=>:center, :style => :bold
				pdf.text "Av. Los Ilustres, Ciudad Universitaria de Caracas, Facultad de Ciencias, \n Edificio del Decanato, Planta Baja, Los Chaguaramos, Caracas-Venezuela\n Teléfono/Fax: 58-212-605.11.65 / 605.11.63 / E-mail: duberly.medina@ciens.ucv.ve",  :size=>7 , :align=>:center
			end.draw
		end
		#######
		
		pdf.text("ADECUACIÓN DEL PLAN DE FORMACIÓN Y CAPACITACIÓN DE DOCENTES EN LA CATEGORÍA DE INSTRUCTOR\n\n", :align=>:center, :style => :bold) # titulo del documento
		
		pdf.bounding_box([0,pdf.bounds.top], :width=>350, :height=>675) do # permite establecer el espacio en donde se puede escribir en el docuemnto
			pdf.move_down(35)		
			# Datos de la dependencia
			pdf.text("1.- DATOS DE LA DEPENDENCIA:", :style => :bold, :size  => 10)
			
			if plan.adscripcion_docencia == nil
				plan.adscripcion_docencia= ""
				plan.save
			end

			if plan.adscripcion_investigacion == nil
				plan.adscripcion_investigacion= ""
				plan.save
			end

			if instructor.area == nil
				instructor.area= ""
				instructor.save
			end

			if instructor.subarea == nil
				instructor.subarea= ""
				instructor.save
			end

			if instructor.grado_instruccion == nil
				instructor.grado_instruccion= ""
				instructor.save
			end

			data1 = [[{:text=>"Escuela o Instituto:", :font_style => :bold}, {:text => escuela.nombre, :align=>:left}],
					[{:text=>"Área:", :font_style => :bold}, {:text => instructor.area , :align=>:left}], 
					[{:text=>"Fecha de realización del presente documento:", :font_style => :bold},{:text => fechaActual, :align=>:left}],
					[{:text=>"Unidad de Adscripción de Docencia:", :font_style => :bold},{:text => plan.adscripcion_docencia,  :align=>:left}],
					[{:text=>"Unidad de Adscripción de Investigación:", :font_style => :bold},{:text => plan.adscripcion_investigacion,  :align=>:left}]] # datos que se desean en la tabla
		  
			pdf.table data1, # lineas para generar la tabla en el docuemnto
			:border_style => :grid, 
			:font_size  => 10, 
			:font_style => :blod, 
			:horizontal_padding => 6, 
			:vertical_padding   => 3, 
			:border_width => 0.7,  
			:column_widths => { 0 => 130, 1 => 390}, 
			:position => :left, 
			:align => { 0 => :left, 1 => :right}
						
			blanco=' '
			if instructor.apellidos==nil
				instructor.apellidos=""
				instructor.save
			end
			if instructor.nombres==nil
				instructor.nombres=""
				instructor.save
			end
			if instructor.telefono1==nil
				instructor.telefono1=""
				instructor.save
			end
			if instructor.telefono2==nil
				instructor.telefono2=""
				instructor.save
			end


			pdf.text("\n")
			pdf.text("2.- DATOS DEL INSTRUCTOR EN FORMACIÓN:", :style => :bold, :size  => 10)
			dataa2 = [
			[{:text=>"Fecha del Concurso de Oposición:", :font_style=>:bold},{:text => fechaConcurso.to_s, :align=>:left}],
			[{:text=>"Apellidos y Nombres:", :font_style => :bold}, {:text => instructor.nombres.to_s.split.map(&:capitalize).join(' ') + " " + instructor.apellidos.to_s.split.map(&:capitalize).join(' '), :align=>:left}],
			[{:text=>"Cédula de Identidad:", :font_style => :bold}, {:text => instructor.ci.to_s, :align=>:left}],
			[{:text=>"Correo Electrónico:", :font_style => :bold},{:text => correoi,  :align=>:left}],
			[{:text=>"Teléfono Celular:", :font_style => :bold},{:text => instructor.telefono1, :align=>:left}],
			[{:text=>"Otro teléfono:", :font_style => :bold},{:text => instructor.telefono2,  :align=>:left}]			
		  ] # datos que se desean en la tabla
			
			pdf.table dataa2,  # lineas para generar la tabla en el docuemnto
			:border_style => :grid, #:underline_header
			:font_size  => 10, 
			:horizontal_padding => 6,
			:vertical_padding   => 3,
			:border_width => 0.7, 
			:column_widths => { 0 => 130, 1 => 390}, 
			:position => :left,
			:align => { 0 => :left, 1 => :right}
			
			pdf.text("\n")
			pdf.text("3.- PERFIL DE INSTRUCTOR EN FORMACIÓN:", :style => :bold, :size  => 10)
			
			data3 = [ 
			[{:text=>"Grado de Instrucción:",:font_style => :bold}, {:text => instructor.grado_instruccion, :align=>:left}],
			[{:text=>"Área:", :font_style => :bold}, {:text => instructor.area, :align=>:left}],
			[{:text=>"Sub Área u Opción:", :font_style => :bold},{:text => instructor.subarea, :align=>:left}]	
			] # datos que se desean en la tabla
				
			pdf.table data3,  # lineas para generar la tabla en el docuemnto
			:border_style => :grid, #:underline_header
			:font_size  => 10, 
			:horizontal_padding => 6,
			:vertical_padding   => 3,
			:border_width => 0.7, 
			:column_widths => { 0 => 130, 1=>390}, 
			:position => :left,
			:align => { 0 => :left, 1 => :right}
			
			
			salto='\n'
			pdf.text("\n")
			pdf.text("4.- DATOS DEL TUTOR ENCARGADO:", :style => :bold, :size  => 10)
			if !tutor.telefono2.blank?
				dataa4 = [
				[{:text=>"Apellidos y Nombres:", :font_style => :bold}, {:text => tutor.nombres.to_s.split.map(&:capitalize).join(' ') + " " + tutor.apellidos.to_s.split.map(&:capitalize).join(' ') , :align=>:left}],
				[{:text=>"Dirección:", :font_style => :bold},{:text => tutor.direccion, :align=>:left}],
				[{:text=>"Correo Electrónico:", :font_style => :bold},{:text => correot,  :align=>:left}],
				[{:text=>"Telefono Celular:", :font_style => :bold},{:text => tutor.telefono1,  :align=>:left}]	,		
				[{:text=>"Otro Telefono:", :font_style => :bold},{:text => tutor.telefono2,  :align=>:left}]			
			  ] # datos que se desean en la tabla
			else
				dataa4 = [	
				[{:text=>"Apellidos y Nombres:", :font_style => :bold}, {:text => tutor.nombres.to_s.split.map(&:capitalize).join(' ') + " " + tutor.apellidos.to_s.split.map(&:capitalize).join(' ') , :align=>:left}],
				[{:text=>"Dirección:", :font_style => :bold},{:text => "No posee", :align=>:left}],
				[{:text=>"Correo Electrónico:", :font_style => :bold},{:text => correot,  :align=>:left}],
				[{:text=>"Telefono Celular:", :font_style => :bold},{:text => "No posee",  :align=>:left}],		
				[{:text=>"Otro Telefono:", :font_style => :bold},{:text => "No posee",  :align=>:left}]					  ] #
			end
			pdf.table dataa4,  # lineas para generar la tabla en el docuemnto
			:border_style => :grid, #:underline_header
			:font_size  => 10, 
			:horizontal_padding => 6,
			:vertical_padding   => 3,
			:border_width => 0.7, 
			:column_widths => { 0 => 130, 1=>390}, 
			:position => :left,
			:align => { 0 => :left, 1 => :right}
			
			
			salto='\n'
			pdf.text("\n")
			
			pdf.text("5.- ACTIVIDADES A REALIZAR POR EL INSTRUCTOR:", :style => :bold, :size  => 10)
			
			data4= [[{:text=>"PRIMER SEMESTRE ", :font_style => :bold}],
				[{:text=>"5.1.- DOCENCIA:",:font_style => :bold }]] # datos que se desean en la tabla
			
			pdf.table data4,  # lineas para generar la tabla en el docuemnto
			:border_style => :grid, #:underline_header
			:font_size  => 10, 
			:horizontal_padding => 6,
			:vertical_padding   => 3,
			:border_width => 0.7, 
			:column_widths => { 0 => 520}, 
			:position => :left,
			:align => { 0 => :left}
						
			if pactv_docencia != []
				pactv_docencia.each do |actv|
					data5 = [[{:text=>  actv.actividad ,  :align=>:left}]] # datos que se desean en la tabla
					
					pdf.table data5, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 10, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
				end	
			else
				data5 = [[{:text=>  "No hubo." ,  :align=>:left}]] # datos que se desean en la tabla
				pdf.table data5, # lineas para generar la tabla en el docuemnto
				:border_style => :grid, #:underline_header
				:font_size  => 10, 
				:horizontal_padding => 6,
				:vertical_padding   => 3,
				:border_width => 0.7, 
				:column_widths => { 0 => 520}, 
				:position => :left,
				:align => { 0 => :left}
			end
			
			data61=[[{:text=>"5.2.- INVESTIGACIÓN:", :font_style => :bold}]] # datos que se desean en la tabla
			pdf.table data61, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 10, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
					
			if pactv_investigacion != []
				pactv_investigacion.each do |actv|
					data6= [[{:text=>  actv.actividad , :align=>:left}]] # datos que se desean en la tabla
					
					pdf.table data6, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 10, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
				end
			else
				data6= [[{:text=>  "No hubo." , :align=>:left}]]# datos que se desean en la tabla
					
					pdf.table data6, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 10, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
			end
			
			data81=[[{:text=>"5.3.- FORMACIÓN:", :font_style => :bold}]] # datos que se desean en la tabla
			pdf.table data81, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 10, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
			
			if pactv_formacion != []
				pactv_formacion.each do |actv|
					data8=[[{:text=> actv.actividad , :aling=> :left}]] # datos que se desean en la tabla
						
					pdf.table data8, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 10, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
				end
			else
				data8=[[{:text=>  "No hubo." , :aling=> :left}]] # datos que se desean en la tabla
					
				pdf.table data8, # lineas para generar la tabla en el docuemnto
				:border_style => :grid, #:underline_header
				:font_size  => 10, 
				:horizontal_padding => 6,
				:vertical_padding   => 3,
				:border_width => 0.7, 
				:column_widths => { 0 => 520}, 
				:position => :left,
				:align => { 0 => :left}
			end
			
			
			data71=[[{:text=>"5.4.- EXTENSIÓN:", :font_style => :bold}]]# datos que se desean en la tabla
			
			pdf.table data71, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 10, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
			
			if pactv_extension != []
				pactv_extension.each do |actv|
					data7=[[{:text=>  actv.actividad , :aling=> :left}]] # datos que se desean en la tabla
					
					pdf.table data7, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 10, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
					
				end			
			else
				data7=[[{:text=>  "No hubo." , :aling=> :left}]] # datos que se desean en la tabla
					
				pdf.table data7, # lineas para generar la tabla en el docuemnto
				:border_style => :grid, #:underline_header
				:font_size  => 10, 
				:horizontal_padding => 6,
				:vertical_padding   => 3,
				:border_width => 0.7, 
				:column_widths => { 0 => 520}, 
				:position => :left,
				:align => { 0 => :left}
			end
							
			data91=[[{:text=>"5.5.- OTRAS ACTIVIDADES:", :font_style => :bold}]] # datos que se desean en la tabla
			
			pdf.table data91, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 10, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
			
			if pactv_otras != []
				pactv_otras.each do |actv|
					data9 =[[{:text => actv.actividad , :aling=> :left}]] # datos que se desean en la tabla
					
					pdf.table data9, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 10, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
				end
			else
				data9 =[[{:text => "No hubo." , :aling=> :left}]] # datos que se desean en la tabla
				
				pdf.table data9, # lineas para generar la tabla en el docuemnto
				:border_style => :grid, #:underline_header
				:font_size  => 10, 
				:horizontal_padding => 6,
				:vertical_padding   => 3,
				:border_width => 0.7, 
				:column_widths => { 0 => 520}, 
				:position => :left,
				:align => { 0 => :left}
			end

			data10 = [[{:text=>"SEGUNDO SEMESTRE ", :font_style => :bold}], [{:text=>"5.1.- DOCENCIA:",:font_style => :bold }]] # datos que se desean en la tabla
			
			pdf.table data10, # lineas para generar la tabla en el docuemnto
			:border_style => :grid, #:underline_header
			:font_size  => 10, 
			:horizontal_padding => 6,
			:vertical_padding   => 3,
			:border_width => 0.7, 
			:column_widths => { 0 => 520}, 
			:position => :left,
			:align => { 0 => :left}
			
			if sactv_docencia != []
				sactv_docencia.each do |actv|
					data11 = [[{:text=>  actv.actividad ,  :align=>:left}]]# datos que se desean en la tabla
					
					pdf.table data11, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 10, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
				end	
			else
				data11 = [[{:text=>  "No hubo." ,  :align=>:left}]]# datos que se desean en la tabla
				pdf.table data11, # lineas para generar la tabla en el docuemnto
				:border_style => :grid, #:underline_header
				:font_size  => 10, 
				:horizontal_padding => 6,
				:vertical_padding   => 3,
				:border_width => 0.7, 
				:column_widths => { 0 => 520}, 
				:position => :left,
				:align => { 0 => :left}
			end
			
			data121= [[{:text=>"5.2.- INVESTIGACIÓN:", :font_style => :bold}]] # datos que se desean en la tabla
			
			pdf.table data121, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 10, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
			
			if sactv_investigacion != []
				sactv_investigacion.each do |actv|
					data12= [[{:text=>  actv.actividad , :align=>:left}]] # datos que se desean en la tabla
					
					pdf.table data12, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 10, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
				end
			else
				data12= [[{:text=>  "No hubo." , :align=>:left}]] # datos que se desean en la tabla
					
					pdf.table data12, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 10, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
			end
			
			data141=[[{:text=>"5.3.- FORMACIÓN:", :font_style => :bold}]]# datos que se desean en la tabla
			
			pdf.table data141, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 10, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
			
			
			if sactv_formacion != []
				sactv_formacion.each do |actv|
					data14=[[{:text=> actv.actividad , :aling=> :left}]] # datos que se desean en la tabla
						
					pdf.table data14, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 10, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
				end
			else
				data14=[[{:text=>  "No hubo." , :aling=> :left}]] # datos que se desean en la tabla
					
				pdf.table data14, # lineas para generar la tabla en el docuemnto
				:border_style => :grid, #:underline_header
				:font_size  => 10, 
				:horizontal_padding => 6,
				:vertical_padding   => 3,
				:border_width => 0.7, 
				:column_widths => { 0 => 520}, 
				:position => :left,
				:align => { 0 => :left}
			end
			
			data131=[[{:text=>"5.4.- EXTENSIÓN:", :font_style => :bold}]] # datos que se desean en la tabla
			
			pdf.table data131, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 10, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
			
			if sactv_extension != []
				sactv_extension.each do |actv|
					data13=[[{:text=>  actv.actividad , :aling=> :left}]] # datos que se desean en la tabla
					 
					pdf.table data13, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 10, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
					
				end			
			else
				data13=[[{:text=>  "No hubo." , :aling=> :left}]] # datos que se desean en la tabla
					
				pdf.table data13, # lineas para generar la tabla en el docuemnto
				:border_style => :grid, #:underline_header
				:font_size  => 10, 
				:horizontal_padding => 6,
				:vertical_padding   => 3,
				:border_width => 0.7, 
				:column_widths => { 0 => 520}, 
				:position => :left,
				:align => { 0 => :left}
			end
							
			data151=[[{:text=>"5.5.- OTRAS ACTIVIDADES:", :font_style => :bold}]] # datos que se desean en la tabla
			
			pdf.table data151, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 10, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
			
			if sactv_otras != []
				sactv_otras.each do |actv|
					data15 =[[{:text => actv.actividad , :aling=> :left}]] # datos que se desean en la tabla
					
					pdf.table data15, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 10, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
				end
			else
				data15 =[[{:text => "No hubo." , :aling=> :left}]] # datos que se desean en la tabla
				
				pdf.table data15, # lineas para generar la tabla en el docuemnto
				:border_style => :grid, #:underline_header
				:font_size  => 10, 
				:horizontal_padding => 6,
				:vertical_padding   => 3,
				:border_width => 0.7, 
				:column_widths => { 0 => 520}, 
				:position => :left,
				:align => { 0 => :left}
			end
			
			data152= [[{:text=>"TERCER SEMESTRE ", :font_style => :bold}],
				[{:text=>"5.1.- DOCENCIA:",:font_style => :bold }]] # datos que se desean en la tabla
			 
			pdf.table data152, # lineas para generar la tabla en el docuemnto
			:border_style => :grid, #:underline_header
			:font_size  => 10, 
			:horizontal_padding => 6,
			:vertical_padding   => 3,
			:border_width => 0.7, 
			:column_widths => { 0 => 520}, 
			:position => :left,
			:align => { 0 => :left}
						
			if tactv_docencia != []
				tactv_docencia.each do |actv|
					data153 = [[{:text=>  actv.actividad ,  :align=>:left}]]# datos que se desean en la tabla
					
					pdf.table data153, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 10, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
				end	
			else
				data153 = [[{:text=>  "No hubo." ,  :align=>:left}]]# datos que se desean en la tabla
				pdf.table data153, # lineas para generar la tabla en el docuemnto
				:border_style => :grid, #:underline_header
				:font_size  => 10, 
				:horizontal_padding => 6,
				:vertical_padding   => 3,
				:border_width => 0.7, 
				:column_widths => { 0 => 520}, 
				:position => :left,
				:align => { 0 => :left}
			end
			
			data154=[[{:text=>"5.2.- INVESTIGACIÓN:", :font_style => :bold}]] # datos que se desean en la tabla
			pdf.table data154, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 10, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
					
			if tactv_investigacion != []
				tactv_investigacion.each do |actv|
					data155= [[{:text=>  actv.actividad , :align=>:left}]] # datos que se desean en la tabla
					
					pdf.table data155, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 10, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
				end
			else
				data155= [[{:text=>  "No hubo." , :align=>:left}]] # datos que se desean en la tabla
					
					pdf.table data155, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 10, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
			end
			
			data156=[[{:text=>"5.3.- FORMACIÓN:", :font_style => :bold}]] # datos que se desean en la tabla
			pdf.table data156, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 10, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
			
			if tactv_formacion != []
				tactv_formacion.each do |actv|
					data157=[[{:text=> actv.actividad , :aling=> :left}]] # datos que se desean en la tabla
						
					pdf.table data157, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 10, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
				end
			else
				data157=[[{:text=>  "No hubo." , :aling=> :left}]] # datos que se desean en la tabla
					
				pdf.table data157, # lineas para generar la tabla en el docuemnto
				:border_style => :grid, #:underline_header
				:font_size  => 10, 
				:horizontal_padding => 6,
				:vertical_padding   => 3,
				:border_width => 0.7, 
				:column_widths => { 0 => 520}, 
				:position => :left,
				:align => { 0 => :left}
			end
			
			
			data158=[[{:text=>"5.4.- EXTENSIÓN:", :font_style => :bold}]] # datos que se desean en la tabla
			
			pdf.table data158, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 10, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
			
			if tactv_extension != []
				tactv_extension.each do |actv|
					data159=[[{:text=>  actv.actividad , :aling=> :left}]] # datos que se desean en la tabla
					
					pdf.table data159, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 10, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
					
				end			
			else
				data159=[[{:text=>  "No hubo." , :aling=> :left}]] # datos que se desean en la tabla
					
				pdf.table data159, # lineas para generar la tabla en el docuemnto
				:border_style => :grid, #:underline_header
				:font_size  => 10, 
				:horizontal_padding => 6,
				:vertical_padding   => 3,
				:border_width => 0.7, 
				:column_widths => { 0 => 520}, 
				:position => :left,
				:align => { 0 => :left}
			end
							
			data160=[[{:text=>"5.5.- OTRAS ACTIVIDADES:", :font_style => :bold}]] # datos que se desean en la tabla
			
			pdf.table data160, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 10, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
			
			if tactv_otras != []
				tactv_otras.each do |actv|
					data161 =[[{:text => actv.actividad , :aling=> :left}]] # datos que se desean en la tabla
					
					pdf.table data161, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 10, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
				end
			else
				data161 =[[{:text => "No hubo." , :aling=> :left}]] # datos que se desean en la tabla
				
				pdf.table data161, # lineas para generar la tabla en el docuemnto
				:border_style => :grid, #:underline_header
				:font_size  => 10, 
				:horizontal_padding => 6,
				:vertical_padding   => 3,
				:border_width => 0.7, 
				:column_widths => { 0 => 520}, 
				:position => :left,
				:align => { 0 => :left}
			end

			data162 = [[{:text=>"CUARTO SEMESTRE ", :font_style => :bold}], [{:text=>"5.1.- DOCENCIA:",:font_style => :bold }]] # datos que se desean en la tabla
			
			pdf.table data162, # lineas para generar la tabla en el docuemnto
			:border_style => :grid, #:underline_header
			:font_size  => 10, 
			:horizontal_padding => 6,
			:vertical_padding   => 3,
			:border_width => 0.7, 
			:column_widths => { 0 => 520}, 
			:position => :left,
			:align => { 0 => :left}
			
			if cactv_docencia != []
				cactv_docencia.each do |actv|
					data163 = [[{:text=>  actv.actividad ,  :align=>:left}]] # datos que se desean en la tabla
					
					pdf.table data163, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 10, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
				end	
			else
				data163 = [[{:text=>  "No hubo." ,  :align=>:left}]] # datos que se desean en la tabla
				pdf.table data163, # lineas para generar la tabla en el docuemnto
				:border_style => :grid, #:underline_header
				:font_size  => 10, 
				:horizontal_padding => 6,
				:vertical_padding   => 3,
				:border_width => 0.7, 
				:column_widths => { 0 => 520}, 
				:position => :left,
				:align => { 0 => :left}
			end
			
			data164= [[{:text=>"5.2.- INVESTIGACIÓN:", :font_style => :bold}]] # datos que se desean en la tabla
			
			pdf.table data164, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 10, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
			
			if cactv_investigacion != []
				cactv_investigacion.each do |actv|
					data165= [[{:text=>  actv.actividad , :align=>:left}]] # datos que se desean en la tabla
					
					pdf.table data165, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 10, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
				end
			else
				data165= [[{:text=>  "No hubo." , :align=>:left}]] # datos que se desean en la tabla
					
					pdf.table data165, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 10, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
			end
			
			data166=[[{:text=>"5.3.- FORMACIÓN:", :font_style => :bold}]] # datos que se desean en la tabla
			
			pdf.table data166, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 10, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
			
			
			if cactv_formacion != []
				cactv_formacion.each do |actv|
					data167=[[{:text=> actv.actividad , :aling=> :left}]] # datos que se desean en la tabla
						
					pdf.table data167, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 10, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
				end
			else
				data167=[[{:text=>  "No hubo." , :aling=> :left}]] # datos que se desean en la tabla
					
				pdf.table data167, # lineas para generar la tabla en el docuemnto
				:border_style => :grid, #:underline_header
				:font_size  => 10, 
				:horizontal_padding => 6,
				:vertical_padding   => 3,
				:border_width => 0.7, 
				:column_widths => { 0 => 520}, 
				:position => :left,
				:align => { 0 => :left}
			end
			
			data168=[[{:text=>"5.4.- EXTENSIÓN:", :font_style => :bold}]] # datos que se desean en la tabla
			
			pdf.table data168, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 10, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
			
			if cactv_extension != []
				cactv_extension.each do |actv|
					data169=[[{:text=>  actv.actividad , :aling=> :left}]] # datos que se desean en la tabla
					 
					pdf.table data169,  # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 10, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
					
				end			
			else
				data169=[[{:text=>  "No hubo." , :aling=> :left}]] # datos que se desean en la tabla
					
				pdf.table data169, # lineas para generar la tabla en el docuemnto
				:border_style => :grid, #:underline_header
				:font_size  => 10, 
				:horizontal_padding => 6,
				:vertical_padding   => 3,
				:border_width => 0.7, 
				:column_widths => { 0 => 520}, 
				:position => :left,
				:align => { 0 => :left}
			end
							
			data170=[[{:text=>"5.5.- OTRAS ACTIVIDADES:", :font_style => :bold}]] # datos que se desean en la tabla
			
			pdf.table data170, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 10, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
			
			if cactv_otras != []
				cactv_otras.each do |actv|
					data171 =[[{:text => actv.actividad , :aling=> :left}]] # datos que se desean en la tabla
					
					pdf.table data171, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 10, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
				end
			else
				data171 =[[{:text => "No hubo." , :aling=> :left}]] # datos que se desean en la tabla
				
				pdf.table data171, # lineas para generar la tabla en el docuemnto
				:border_style => :grid, #:underline_header
				:font_size  => 10, 
				:horizontal_padding => 6,
				:vertical_padding   => 3,
				:border_width => 0.7, 
				:column_widths => { 0 => 520}, 
				:position => :left,
				:align => { 0 => :left}
			end
			#Actividades Obligatorias

			data171 = [[{:text=>"ACTIVIDADES OBLIGATORIAS ", :font_style => :bold}], [{:text=>"5.1.- ACTIVIDADES OBLIGATORIAS:",:font_style => :bold }]] # datos que se desean en la tabla
			
			pdf.table data171, # lineas para generar la tabla en el docuemnto
			:border_style => :grid, #:underline_header
			:font_size  => 10, 
			:horizontal_padding => 6,
			:vertical_padding   => 3,
			:border_width => 0.7, 
			:column_widths => { 0 => 520}, 
			:position => :left,
			:align => { 0 => :left}
			
			if dactv_obligatorias != []
				dactv_obligatorias.each do |actv|
					data172 = [[{:text=>  actv.actividad ,  :align=>:left}]] # datos que se desean en la tabla
					
					pdf.table data172, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 10, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
				end	
			else
				data172 = [[{:text=>  "No hubo." ,  :align=>:left}]] # datos que se desean en la tabla
				pdf.table data172, # lineas para generar la tabla en el docuemnto
				:border_style => :grid, #:underline_header
				:font_size  => 10, 
				:horizontal_padding => 6,
				:vertical_padding   => 3,
				:border_width => 0.7, 
				:column_widths => { 0 => 520}, 
				:position => :left,
				:align => { 0 => :left}
			end
					  
			pdf.text("\n")
			data = [
				[{:text=>"Firma del Tutor: \n", :font_style => :bold}, {:text => '', :align=>:left,  :font_style => :bold} ],
				[{:text=>"Adecuación del Plan de Formación y Capacitación Aprobado por el Consejo de Escuela o Instituto en Sesión de Fecha: \n",  :font_style => :bold}, {:text => 'Adecuación del Plan de Formación y Capacitación Aprobado por el Consejo de la Facultad de Ciencias en Sesión de Fecha:', :align=>:left,  :font_style => :bold} ]
			] # cuadro final del documento
		  
			pdf.table data, # lineas para generar la tabla en el docuemnto
			:border_style => :grid, #:underline_header
			:font_size  => 8, 
			:horizontal_padding => 6,
			:vertical_padding   => 15,
			:border_width => 0.7, 
			:column_widths => {0 => 260, 1=>260}, 
			:position => :left,
			:align => {0 => :left, 1=> :left}
			
			@i = soportes.size
			pdf.text("\n")
			pdf.text("Cantidad de soportes adjuntos:"+ @i.to_s+" \n", :style => :bold, :size  => 10)
			
		end
		###################
		if numeroDeVersion == nil
			nombre_archivo= instructor.ci.to_s+'-'+fechaActual+'-adecuacion.pdf' # nombre del dcouemrnto
		else
			nombre_archivo= instructor.ci.to_s+'-'+fechaActual+'-adecuacionV'+numeroDeVersion.to_s+'.pdf' # nombre del dcouemrnto
		end	
		url = "#{Rails.root}/tmp/PDFs/" + nombre_archivo
		pdf.render_file(url) # creación del docuemnto bajo su nombre
		return nombre_archivo
	end
#########################################################################################################################################################################
	def self.pdf_informe(tipo_informe,escuela,informe, adecuacion, tutor, instructor, pactv_docencia, pactv_investigacion, pactv_extension, pactv_formacion, pactv_otras, sactv_docencia, sactv_investigacion, sactv_extension, sactv_otras, sactv_formacion,  tactv_docencia, tactv_investigacion, tactv_extension,tactv_formacion, tactv_otras, cactv_docencia, cactv_investigacion, cactv_extension, cactv_formacion, cactv_otras, info_docencia, info_investigacion,info_formacion, info_extension, info_otras,resx,resultados,actividadese,observaciont, resultTP, resultPP, resultO, resultAEC, resultOEC, resultDCS,documents, numeroDeVersion, factv_obligatoria, actividadesaobli)
		noplan_a=[]
		noplan_na=[]
		res_tp=[]
		res_ppcc=[]
		res_otp=[]
		res_aec=[]
		res_oec=[]
		res_dctsc=[]
		resultados.each do |resultado|
			if resultado.tipo_resultado_id == 1
				res_tp.push(resultado)
			elsif resultado.tipo_resultado_id == 2
				res_ppcc.push(resultado)
			elsif resultado.tipo_resultado_id == 4
				res_otp.push(resultado)
			elsif resultado.tipo_resultado_id == 5
				res_aec.push(resultado)
			elsif resultado.tipo_resultado_id == 6
				res_oec.push(resultado)
			elsif resultado.tipo_resultado_id == 7
				res_dctsc.push(resultado)
			end
		end

		puts "PDFFF"

		# se invocan la bibliotecas
		require "prawn"
		require 'prawn/layout'

		pdf= Prawn::Document.new(:background=>"#{Rails.root}/app/assets/images/fondo.png", :top_margin=> 99, :bottom_margin=>35, :page_size => 'A4') # se coloca la imagen de fondo del documento
		
		pdf.repeat :all do
			#Encabezado
			pdf.text_box "UNIVERSIDAD CENTRAL DE VENEZUELA \n FACULTAD DE CIENCIAS\n "+escuela.nombre.upcase+"\n\n",:style => :bold, :at => [pdf.bounds.right-490, pdf.bounds.top+59]
		end
		pdf.repeat :all do
			#Pie de pagina
			point = [pdf.bounds.right-525, pdf.bounds.bottom+35]
			pdf.lazy_bounding_box(point, :width => 500) do
				pdf.text " Universidad Central de Venezuela - Facultad de Ciencias \n", :size=>9 , :align=>:center, :style => :bold
				pdf.text "Av. Los Ilustres, Ciudad Universitaria de Caracas, Facultad de Ciencias, \n Edificio del Decanato, Planta Baja, Los Chaguaramos, Caracas-Venezuela\n Teléfono/Fax: 58-212-605.11.65 / 605.11.63 / E-mail: duberly.medina@ciens.ucv.ve",  :size=>7 , :align=>:center
			end.draw
		end
		
		#titulo del documento
		ati = tipo_informe.tipo.upcase
		pdf.text("INFORME #{ati} DE ACTIVIDADES REALIZADAS POR EL INSTRUCTOR DURANTE LA EJECUCIÓN DE SU PLAN DE FORMACIÓN Y CAPACITACIÓN\n\n", :align=>:center, :style => :bold) # titulo del documento
		
	################
	pdf.bounding_box([0,pdf.bounds.top], :width=>350, :height=>675) do # permite establecer el espacio en donde se puede escribir en el docuemnto
		pdf.move_down(35)	
		#apartado 1
			pdf.text("1.- DATOS DEL INSTRUCTOR EN FORMACIÓN Y SU TUTOR:", :style => :bold, :size  => 10)
			
			blanco=' '
			data1 = [
			#[{:text=>"N° del informe", :font_style => :bold}, {:text => informe.numero_informe.to_s, :align=>:left}],
			[{:text=>"N° del informe", :font_style => :bold}, {:text => informe.numero.to_s, :align=>:left}],
			#[{:text=>"Fecha de realización del informe:", :font_style => :bold}, {:text => informe.fecha_informe.to_s, :align=>:left}],
			[{:text=>"Fecha de realización del informe:", :font_style => :bold}, {:text => informe.fecha_creacion.to_s, :align=>:left}],
			#[{:text=>"Apellidos y Nombres del Instructor:", :font_style => :bold},{:text => instructor.apellidos+blanco+instructor.nombres, :align=>:left}],
			[{:text=>"Apellidos y Nombres del Instructor:", :font_style => :bold},{:text => instructor.nombres.to_s.split.map(&:capitalize).join(' ') + " " + instructor.apellidos.to_s.split.map(&:capitalize).join(' '), :align=>:left}],
			#[{:text=>"Cédula de Identidad del Instructor:", :font_style => :bold}, {:text => instructor.ci.to_s, :align=>:left}],
			[{:text=>"Cédula de Identidad del Instructor:", :font_style => :bold}, {:text => instructor.ci.to_s, :align=>:left}],
			#[{:text=>"Período que comprende el Informe:", :font_style => :bold}, {:text => informe.periodo.to_s, :align=>:left}],
			[{:text=>"Período que comprende el Informe:", :font_style => :bold}, {:text => informe.fecha_inicio.to_s + " al " + informe.fecha_fin.to_s, :align=>:left}],
			#[{:text=>"Apellidos y Nombre del Tutor:", :font_style => :bold}, {:text => tutor.nombres, :align=>:left}],
			[{:text=>"Apellidos y Nombre del Tutor:", :font_style => :bold}, {:text => tutor.nombres.to_s.split.map(&:capitalize).join(' ') + " " + tutor.apellidos.to_s.split.map(&:capitalize).join(' '), :align=>:left}],
			#[{:text=>"Cédula de Identidad del Tutor:", :font_style => :bold}, {:text => tutor.ci.to_s, :align=>:left}],
			[{:text=>"Cédula de Identidad del Tutor:", :font_style => :bold}, {:text => tutor.ci.to_s, :align=>:left}],
			#+[{:text=>"Escuela o Instituto de adscripción:", :font_style => :bold}, {:text => escuela.nombre, :align=>:left}]
			[{:text=>"Escuela o Instituto de adscripción:", :font_style => :bold}, {:text => escuela.nombre, :align=>:left}]
		  ]# datos que se desean en la tabla
		  
			pdf.table data1, # lineas para generar la tabla en el docuemnto
			:border_style => :grid, #:underline_header
			:font_size  => 8, 
			:font_style => :blod,
			:horizontal_padding => 6,
			:vertical_padding   => 3,
			:border_width => 0.7, 
			:column_widths => { 0 => 200, 1 => 320}, 
			:position => :left,
			:align => { 0 => :left, 1 => :right}
			
			pdf.text("\n")

			
			#apartado 2
			data2 = [[{:text=>"2.- PRESENTACIÓN DE PLAN DE FORMACIÓN Y CAPACITACIÓN:", :font_style => :bold}]]# datos que se desean en la tabla
			
			pdf.table data2, # lineas para generar la tabla en el docuemnto
			:border_style => :grid, #:underline_header
			:font_size  => 8, 
			:horizontal_padding => 6,
			:vertical_padding   => 3,
			:border_width => 0.7, 
			:column_widths => { 0 => 520}, 
			:position => :left,
			:align => { 0 => :left}
			
			data24= [[{:text=>"PRIMER SEMESTRE ", :font_style => :bold}], [{:text=>"2.1.- DOCENCIA:",:font_style => :bold }]]# datos que se desean en la tabla
			
			pdf.table data24, # lineas para generar la tabla en el docuemnto
			:border_style => :grid, #:underline_header
			:font_size  => 8, 
			:horizontal_padding => 6,
			:vertical_padding   => 3,
			:border_width => 0.7, 
			:column_widths => { 0 => 520}, 
			:position => :left,
			:align => { 0 => :left}
			
			if !pactv_docencia.blank?
				pactv_docencia.each do |actv|
					data25 = [[{:text=>  actv.actividad ,  :align=>:left}]]# datos que se desean en la tabla
					
					pdf.table data25, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
				end	
			else
				data25 = [[{:text=>  "No hubo." ,  :align=>:left}]]# datos que se desean en la tabla
				pdf.table data25, # lineas para generar la tabla en el docuemnto
				:border_style => :grid, #:underline_header
				:font_size  => 8, 
				:horizontal_padding => 6,
				:vertical_padding   => 3,
				:border_width => 0.7, 
				:column_widths => { 0 => 520}, 
				:position => :left,
				:align => { 0 => :left}
			end
			
			data261= [[{:text=>"2.2.- INVESTIGACIÓN:", :font_style => :bold}]]# datos que se desean en la tabla
			
			pdf.table data261, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
			
			if !pactv_investigacion.blank?
				pactv_investigacion.each do |actv|
					data26= [[{:text=>  actv.actividad , :align=>:left}]]# datos que se desean en la tabla
					
					pdf.table data26, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
				end
			else
				data26= [[{:text=>  "No hubo." , :align=>:left}]]# datos que se desean en la tabla
					
					pdf.table data26, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
			end
			
			data281=[[{:text=>"2.3.- FORMACIÓN:", :font_style => :bold}]]# datos que se desean en la tabla
			pdf.table data281, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
			
			
			if !pactv_formacion.blank?
				pactv_formacion.each do |actv|
					data28=[[{:text=> actv.actividad , :aling=> :left}]]# datos que se desean en la tabla
						
					pdf.table data28, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
				end
			else
				data28=[[{:text=>  "No hubo." , :aling=> :left}]]# datos que se desean en la tabla
					
				pdf.table data28, # lineas para generar la tabla en el docuemnto
				:border_style => :grid, #:underline_header
				:font_size  => 8, 
				:horizontal_padding => 6,
				:vertical_padding   => 3,
				:border_width => 0.7, 
				:column_widths => { 0 => 520}, 
				:position => :left,
				:align => { 0 => :left}
			end
			
			data271=[[{:text=>"2.4.- EXTENSIÓN:", :font_style => :bold}]]# datos que se desean en la tabla
			pdf.table data271, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
			
			
			if !pactv_extension.blank?
				pactv_extension.each do |actv|
					data27=[[{:text=>  actv.actividad , :aling=> :left}]]# datos que se desean en la tabla
					
					pdf.table data27, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
					
				end			
			else
				data27=[[{:text=>  "No hubo." , :aling=> :left}]]# datos que se desean en la tabla
					
				pdf.table data27, # lineas para generar la tabla en el docuemnto
				:border_style => :grid, #:underline_header
				:font_size  => 8, 
				:horizontal_padding => 6,
				:vertical_padding   => 3,
				:border_width => 0.7, 
				:column_widths => { 0 => 520}, 
				:position => :left,
				:align => { 0 => :left}
			end
			
			
			
			data291 =[[{:text=>"2.5.- OTRAS ACTIVIDADES:", :font_style => :bold}]]# datos que se desean en la tabla
			
			pdf.table data291, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
			
			
			if !pactv_otras.blank?
				pactv_otras.each do |actv|
					data29 =[[{:text => actv.actividad , :aling=> :left}]]# datos que se desean en la tabla
					
					pdf.table data29, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
				end
			else
				data29 =[[{:text => "No hubo." , :aling=> :left}]]# datos que se desean en la tabla
				
				pdf.table data29, # lineas para generar la tabla en el docuemnto
				:border_style => :grid, #:underline_header
				:font_size  => 8, 
				:horizontal_padding => 6,
				:vertical_padding   => 3,
				:border_width => 0.7, 
				:column_widths => { 0 => 520}, 
				:position => :left,
				:align => { 0 => :left}
			end

			data210 = [[{:text=>"SEGUNDO SEMESTRE ", :font_style => :bold}], [{:text=>"2.1.- DOCENCIA:",:font_style => :bold }]]# datos que se desean en la tabla
			
			pdf.table data210, # lineas para generar la tabla en el docuemnto
			:border_style => :grid, #:underline_header
			:font_size  => 8, 
			:horizontal_padding => 6,
			:vertical_padding   => 3,
			:border_width => 0.7, 
			:column_widths => { 0 => 520}, 
			:position => :left,
			:align => { 0 => :left}
			
			if !sactv_docencia.blank?
				sactv_docencia.each do |actv|
					data211 = [[{:text=>  actv.actividad ,  :align=>:left}]]# datos que se desean en la tabla
					
					pdf.table data211, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
				end	
			else
				data211 = [[{:text=>  "No hubo." ,  :align=>:left}]]# datos que se desean en la tabla
				pdf.table data211, # lineas para generar la tabla en el docuemnto
				:border_style => :grid, #:underline_header
				:font_size  => 8, 
				:horizontal_padding => 6,
				:vertical_padding   => 3,
				:border_width => 0.7, 
				:column_widths => { 0 => 520}, 
				:position => :left,
				:align => { 0 => :left}
			end
			
			data2121= [[{:text=>"2.2.- INVESTIGACIÓN:", :font_style => :bold}]]# datos que se desean en la tabla
			
			pdf.table data2121, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
			
			if !sactv_investigacion.blank?
				sactv_investigacion.each do |actv|
					data212= [[{:text=>  actv.actividad , :align=>:left}]]# datos que se desean en la tabla
					
					pdf.table data212, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
				end
			else
				data212= [[{:text=>  "No hubo." , :align=>:left}]]# datos que se desean en la tabla
					
					pdf.table data212, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
			end
			
			data2141=[[{:text=>"2.3.- FORMACIÓN:", :font_style => :bold}]]# datos que se desean en la tabla
			
			pdf.table data2141, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
			
			if !sactv_formacion.blank?
				sactv_formacion.each do |actv|
					data214=[[{:text=> actv.actividad , :aling=> :left}]]# datos que se desean en la tabla
						
					pdf.table data214, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
				end
			else
				data214=[[{:text=>  "No hubo." , :aling=> :left}]]# datos que se desean en la tabla
					
				pdf.table data214, # lineas para generar la tabla en el docuemnto
				:border_style => :grid, #:underline_header
				:font_size  => 8, 
				:horizontal_padding => 6,
				:vertical_padding   => 3,
				:border_width => 0.7, 
				:column_widths => { 0 => 520}, 
				:position => :left,
				:align => { 0 => :left}
			end
			
			data2131=[[{:text=>"2.4.- EXTENSIÓN:", :font_style => :bold}]]# datos que se desean en la tabla
			
			pdf.table data2131, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
			
			if !sactv_extension.blank?
				sactv_extension.each do |actv|
					data213=[[{:text=>  actv.actividad , :aling=> :left}]]# datos que se desean en la tabla
					
					pdf.table data213, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
					
				end			
			else
				data213=[[{:text=>  "No hubo." , :aling=> :left}]]# datos que se desean en la tabla
					
				pdf.table data213, # lineas para generar la tabla en el docuemnto
				:border_style => :grid, #:underline_header
				:font_size  => 8, 
				:horizontal_padding => 6,
				:vertical_padding   => 3,
				:border_width => 0.7, 
				:column_widths => { 0 => 520}, 
				:position => :left,
				:align => { 0 => :left}
			end
			
			
			
			data2151 =[[{:text=>"2.5.- OTRAS ACTIVIDADES:", :font_style => :bold}]]# datos que se desean en la tabla
					
					pdf.table data2151, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
			
			
			if !sactv_otras.blank?
				sactv_otras.each do |actv|
					data215 =[[{:text => actv.actividad , :aling=> :left}]]# datos que se desean en la tabla
					
					pdf.table data215, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
				end
			else
				data215 =[[{:text => "No hubo." , :aling=> :left}]]# datos que se desean en la tabla
				
				pdf.table data215, # lineas para generar la tabla en el docuemnto
				:border_style => :grid, #:underline_header
				:font_size  => 8, 
				:horizontal_padding => 6,
				:vertical_padding   => 3,
				:border_width => 0.7, 
				:column_widths => { 0 => 520}, 
				:position => :left,
				:align => { 0 => :left}
			end
			
			data152= [[{:text=>"TERCER SEMESTRE ", :font_style => :bold}],
				[{:text=>"2.1.- DOCENCIA:",:font_style => :bold }]]# datos que se desean en la tabla
			
			pdf.table data152, # lineas para generar la tabla en el docuemnto
			:border_style => :grid, #:underline_header
			:font_size  => 8, 
			:horizontal_padding => 6,
			:vertical_padding   => 3,
			:border_width => 0.7, 
			:column_widths => { 0 => 520}, 
			:position => :left,
			:align => { 0 => :left}
						
			if !tactv_docencia.blank?
				tactv_docencia.each do |actv|
					data153 = [[{:text=>  actv.actividad ,  :align=>:left}]]# datos que se desean en la tabla
					
					pdf.table data153, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
				end	
			else
				data153 = [[{:text=>  "No hubo." ,  :align=>:left}]]# datos que se desean en la tabla
				pdf.table data153, # lineas para generar la tabla en el docuemnto
				:border_style => :grid, #:underline_header
				:font_size  => 8, 
				:horizontal_padding => 6,
				:vertical_padding   => 3,
				:border_width => 0.7, 
				:column_widths => { 0 => 520}, 
				:position => :left,
				:align => { 0 => :left}
			end
			
			data154=[[{:text=>"2.2.- INVESTIGACIÓN:", :font_style => :bold}]]# datos que se desean en la tabla
			pdf.table data154, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
					
			if !tactv_investigacion.blank?
				tactv_investigacion.each do |actv|
					data155= [[{:text=>  actv.actividad , :align=>:left}]]# datos que se desean en la tabla
					
					pdf.table data155, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
				end
			else
				data155= [[{:text=>  "No hubo." , :align=>:left}]]# datos que se desean en la tabla
					
					pdf.table data155, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
			end
			
			data156=[[{:text=>"2.3.- FORMACIÓN:", :font_style => :bold}]]# datos que se desean en la tabla
			pdf.table data156, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
			
			if !tactv_formacion.blank?
				tactv_formacion.each do |actv|
					data157=[[{:text=> actv.actividad , :aling=> :left}]]# datos que se desean en la tabla
						
					pdf.table data157, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
				end
			else
				data157=[[{:text=>  "No hubo." , :aling=> :left}]]# datos que se desean en la tabla
					
				pdf.table data157, # lineas para generar la tabla en el docuemnto
				:border_style => :grid, #:underline_header
				:font_size  => 8, 
				:horizontal_padding => 6,
				:vertical_padding   => 3,
				:border_width => 0.7, 
				:column_widths => { 0 => 520}, 
				:position => :left,
				:align => { 0 => :left}
			end
			
			
			data158=[[{:text=>"2.4.- EXTENSIÓN:", :font_style => :bold}]]# datos que se desean en la tabla
			
			pdf.table data158, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
			
			if !tactv_extension.blank?
				tactv_extension.each do |actv|
					data159=[[{:text=>  actv.actividad , :aling=> :left}]]# datos que se desean en la tabla
					
					pdf.table data159, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
					
				end			
			else
				data159=[[{:text=>  "No hubo." , :aling=> :left}]]# datos que se desean en la tabla
					
				pdf.table data159, # lineas para generar la tabla en el docuemnto
				:border_style => :grid, #:underline_header
				:font_size  => 8, 
				:horizontal_padding => 6,
				:vertical_padding   => 3,
				:border_width => 0.7, 
				:column_widths => { 0 => 520}, 
				:position => :left,
				:align => { 0 => :left}
			end
							
			data160=[[{:text=>"2.5.- OTRAS ACTIVIDADES:", :font_style => :bold}]]# cuadro final del documento
			
			pdf.table data160, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
			
			if !tactv_otras.blank?
				tactv_otras.each do |actv|
					data161 =[[{:text => actv.actividad , :aling=> :left}]]# datos que se desean en la tabla
					
					pdf.table data161, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
				end
			else
				data161 =[[{:text => "No hubo." , :aling=> :left}]] # datos que se desean en la tabla
				
				pdf.table data161, # lineas para generar la tabla en el docuemnto
				:border_style => :grid, #:underline_header
				:font_size  => 8, 
				:horizontal_padding => 6,
				:vertical_padding   => 3,
				:border_width => 0.7, 
				:column_widths => { 0 => 520}, 
				:position => :left,
				:align => { 0 => :left}
			end

			data162 = [[{:text=>"CUARTO SEMESTRE ", :font_style => :bold}], [{:text=>"2.1.- DOCENCIA:",:font_style => :bold }]] # datos que se desean en la tabla
			
			pdf.table data162, # lineas para generar la tabla en el docuemnto
			:border_style => :grid, #:underline_header
			:font_size  => 8, 
			:horizontal_padding => 6,
			:vertical_padding   => 3,
			:border_width => 0.7, 
			:column_widths => { 0 => 520}, 
			:position => :left,
			:align => { 0 => :left}
			
			if !cactv_docencia.blank?
				cactv_docencia.each do |actv|
					data163 = [[{:text=>  actv.actividad ,  :align=>:left}]]# datos que se desean en la tabla
					
					pdf.table data163, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
				end	
			else
				data163 = [[{:text=>  "No hubo." ,  :align=>:left}]	] # datos que se desean en la tabla
				pdf.table data163, # lineas para generar la tabla en el docuemnto
				:border_style => :grid, #:underline_header
				:font_size  => 8, 
				:horizontal_padding => 6,
				:vertical_padding   => 3,
				:border_width => 0.7, 
				:column_widths => { 0 => 520}, 
				:position => :left,
				:align => { 0 => :left}
			end
			
			data164= [[{:text=>"2.2.- INVESTIGACIÓN:", :font_style => :bold}]] # datos que se desean en la tabla
			
			pdf.table data164, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
			
			if !cactv_investigacion.blank?
				cactv_investigacion.each do |actv|
					data165= [[{:text=>  actv.actividad , :align=>:left}]] # datos que se desean en la tabla
					
					pdf.table data165, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
				end
			else
				data165= [[{:text=>  "No hubo." , :align=>:left}]] # datos que se desean en la tabla
					
					pdf.table data165, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
			end
			
			data166=[[{:text=>"2.3.- FORMACIÓN:", :font_style => :bold}]] # datos que se desean en la tabla
			
			pdf.table data166, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
			
			
			if !cactv_formacion.blank?
				cactv_formacion.each do |actv|
					data167=[[{:text=> actv.actividad , :aling=> :left}]] # datos que se desean en la tabla
						
					pdf.table data167, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
				end
			else
				data167=[[{:text=>  "No hubo." , :aling=> :left}]] # datos que se desean en la tabla
					
				pdf.table data167, # lineas para generar la tabla en el docuemnto
				:border_style => :grid, #:underline_header
				:font_size  => 8, 
				:horizontal_padding => 6,
				:vertical_padding   => 3,
				:border_width => 0.7, 
				:column_widths => { 0 => 520}, 
				:position => :left,
				:align => { 0 => :left}
			end
			
			data168=[[{:text=>"2.4.- EXTENSIÓN:", :font_style => :bold}]] # datos que se desean en la tabla
			
			pdf.table data168, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
			
			if !cactv_extension.blank?
				cactv_extension.each do |actv|
					data169=[[{:text=>  actv.actividad , :aling=> :left}]] # datos que se desean en la tabla
					
					pdf.table data169, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
					
				end			
			else
				data169=[[{:text=>  "No hubo." , :aling=> :left}]] # datos que se desean en la tabla
					
				pdf.table data169, # lineas para generar la tabla en el docuemnto
				:border_style => :grid, #:underline_header
				:font_size  => 8, 
				:horizontal_padding => 6,
				:vertical_padding   => 3,
				:border_width => 0.7, 
				:column_widths => { 0 => 520}, 
				:position => :left,
				:align => { 0 => :left}
			end
							
			data170=[[{:text=>"2.5.- OTRAS ACTIVIDADES:", :font_style => :bold}]] # datos que se desean en la tabla
			
			pdf.table data170, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
			
			if !cactv_otras.blank?
				cactv_otras.each do |actv|
					data171 =[[{:text => actv.actividad , :aling=> :left}]] # datos que se desean en la tabla
					
					pdf.table data171, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
				end
			else
				data171 =[[{:text => "No hubo." , :aling=> :left}]] # datos que se desean en la tabla
				
				pdf.table data171, # lineas para generar la tabla en el docuemnto
				:border_style => :grid, #:underline_header
				:font_size  => 8, 
				:horizontal_padding => 6,
				:vertical_padding   => 3,
				:border_width => 0.7, 
				:column_widths => { 0 => 520}, 
				:position => :left,
				:align => { 0 => :left}
			end
			data162 = [[{:text=>"ACTIVIDADES OBLIGATORIAS", :font_style => :bold}], [{:text=>"2.1.- Actividades Obligatorias:",:font_style => :bold }]] # datos que se desean en la tabla
			
			pdf.table data162, # lineas para generar la tabla en el docuemnto
			:border_style => :grid, #:underline_header
			:font_size  => 8, 
			:horizontal_padding => 6,
			:vertical_padding   => 3,
			:border_width => 0.7, 
			:column_widths => { 0 => 520}, 
			:position => :left,
			:align => { 0 => :left}
			
			if !factv_obligatoria.blank?
				factv_obligatoria.each do |actv|
					data163 = [[{:text=>  actv.actividad ,  :align=>:left}]]# datos que se desean en la tabla
					
					pdf.table data163, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
				end	
			else
				data163 = [[{:text=>  "No hubo." ,  :align=>:left}]	] # datos que se desean en la tabla
				pdf.table data163, # lineas para generar la tabla en el docuemnto
				:border_style => :grid, #:underline_header
				:font_size  => 8, 
				:horizontal_padding => 6,
				:vertical_padding   => 3,
				:border_width => 0.7, 
				:column_widths => { 0 => 520}, 
				:position => :left,
				:align => { 0 => :left}
			end
			pdf.text("\n")
			
			pdf.text("ACTIVIDADES DESARROLLADAS \n")
			pdf.text("\n")
			salto='\n'
			
			#apartado 3
			pdf.text("3.- ACTIVIDADES DE DOCENCIA:", :style => :bold, :size  => 10)
			
				data3 = [[{:text=>"ACTIVIDAD DE DOCENCIA PROGRAMADA",:align=>:center,:font_style => :bold}, {:text =>"ACTIVIDAD DE DOCENCIA EJECUTADA", :align=>:center,:font_style => :bold},{:text =>"OBSERVACIONES", :align=>:center,:font_style => :bold}]] # datos que se desean en la tabla
			  
			
			pdf.table data3, # lineas para generar la tabla en el docuemnto
			:border_style => :grid, #:underline_header
			:font_size  => 8,
			:horizontal_padding => 3,
			:vertical_padding   => 3,
			:border_width => 0.7, 
			:column_widths => { 0 => 173, 1 => 173, 2 => 173}, 
			:position => :left,
			:align => { 0 => :left, 1 => :left, 2=> :left}
			
			if !info_docencia.blank?
				info_docencia.each do |actv|
					ae = InformeActividad.where(actividad_id: actv.id, informe: informe.id).take
					ai = ActividadEjecutada.where(informe_actividad_id: ae.id).take
        			obs= ObservacionTutor.where(informe_actividad_id: ae.id).take
        			if !obs.blank?
        				if !ai.blank?
							data31 = [[{:text=> actv.actividad.to_s, :align=>:left}, {:text => ai.descripcion.to_s, :align=>:left}, {:text => obs.observaciones.to_s, :align=>:left}]] # datos que se desean en la tabla
						else
							data31 = [[{:text=> actv.actividad.to_s, :align=>:left}, {:text => "", :align=>:left}, {:text => obs.observaciones.to_s, :align=>:left}]] # datos que se desean en la tabla
						end
					else
						if !ai.blank?
							data31 = [[{:text=> actv.actividad.to_s, :align=>:left}, {:text => ai.descripcion.to_s, :align=>:left}, {:text => "", :align=>:left}]] # datos que se desean en la tabla
						else
							data31 = [[{:text=> actv.actividad.to_s, :align=>:left}, {:text => "", :align=>:left}, {:text => "", :align=>:left}]] # datos que se desean en la tabla
						end
					end
					pdf.table data31, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8,
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 173, 1 => 173, 2 => 173}, 
					:position => :left,
					:align => { 0 => :left, 1 => :left, 2=> :left}
				end	
			else
				data31 = [[{:text=>  "No hubo." ,  :align=>:left}, {:text=>  "" ,  :align=>:left}, {:text=>  "" ,  :align=>:left}]] # datos que se desean en la tabla
				pdf.table data31, # lineas para generar la tabla en el docuemnto
				:border_style => :grid, #:underline_header
				:font_size  => 8,
				:horizontal_padding => 6,
				:vertical_padding   => 3,
				:border_width => 0.7, 
				:column_widths => { 0 => 173, 1 => 173, 2 => 173}, 
				:position => :left,
				:align => { 0 => :left, 1 => :left, 2=> :left}
			end
			
			
			
			pdf.text("\n")
			
			#aparatado 4 Y RESULTADOS
			pdf.text("4.- ACTIVIDADES DE INVESTIGACIÓN:", :style => :bold, :size  => 10)
			data4 = [[{:text=>"ACTIVIDAD DE INVESTIGACIÓN PROGRAMADA",:align=>:center,:font_style => :bold}, {:text =>"ACTIVIDAD DE INVESTIGACION EJECUTADA", :align=>:center,:font_style => :bold},{:text =>"OBSERVACIONES", :align=>:center,:font_style => :bold} ]] # datos que se desean en la tabla
			
			pdf.table data4, # lineas para generar la tabla en el docuemnto
			:border_style => :grid, #:underline_header
			:font_size  => 8, 
			:horizontal_padding => 6,
			:vertical_padding   => 3,
			:border_width => 0.7, 
			:column_widths => { 0 => 173, 1 => 173, 2 => 173}, 
			:position => :left,
			:align => { 0 => :left, 1 => :left, 2=> :left}
			aee = 0
			if !info_investigacion.blank?
				info_investigacion.each do |actv|
					ae = InformeActividad.where(actividad_id: actv.id, informe: informe.id).take
					ai = ActividadEjecutada.where(informe_actividad_id: ae.id).take
        			obs= ObservacionTutor.where(informe_actividad_id: ae.id).take
        			if !obs.blank?
        				if !ai.blank?
							data41 = [[{:text=> actv.actividad.to_s, :align=>:left}, {:text => ai.descripcion.to_s, :align=>:left}, {:text => obs.observaciones.to_s, :align=>:left}]] # datos que se desean en la tabla
						else
							data41 = [[{:text=> actv.actividad.to_s, :align=>:left}, {:text => "", :align=>:left}, {:text => obs.observaciones.to_s, :align=>:left}]] # datos que se desean en la tabla
						end
					else
						if !ai.blank?
							data41 = [[{:text=> actv.actividad.to_s, :align=>:left}, {:text => ai.descripcion.to_s, :align=>:left}, {:text => "", :align=>:left}]] # datos que se desean en la tabla
						else
							data41 = [[{:text=> actv.actividad.to_s, :align=>:left}, {:text => "", :align=>:left}, {:text => "", :align=>:left}]] # datos que se desean en la tabla
						end
					end
					pdf.table data41, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8,
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7 ,
					:column_widths => { 0 => 173, 1 => 173, 2 => 173},
					:position => :left,
					:align => { 0 => :left, 1 => :left, 2=> :left}
						
				 end	
			else
				data41 = [[{:text=>  "No hubo." ,  :align=>:left}, {:text=>  "" ,  :align=>:left}, {:text=>  "" ,  :align=>:left}]] # datos que se desean en la tabla
				pdf.table data41,
				:border_style => :grid, #:underline_header
				:font_size  => 8,
				:horizontal_padding => 6,
				:vertical_padding   => 3,
				:border_width => 0.7 ,
				:column_widths => { 0 => 173, 1 => 173, 2 => 173},
				:position => :left,
				:align => { 0 => :left, 1 => :left, 2=> :left}
			end
				
				res1 = [[{:text=> "4.1.- Divulgación de resultados:", :font_style => :bold}],
					[{:text=> "4.1.1.- Trabajos publicados (libros, revistas, artículos de prensa, CDs, manuales, publicaciones electrónicas, etc.): \n", :font_style => :bold}]] # cuadro final del documento
			
				pdf.table res1, # lineas para generar la tabla en el docuemnto
				:border_style =>:grid, #:underline_header
				:font_size  => 8, 
				:horizontal_padding => 6,
				:vertical_padding   => 3,
				:border_width => 0.7, 
				:column_widths => { 0 => 520}, 
				:position => :left,
				:align => { 0 => :left}

				if resultTP != []
					resultTP.each do |res|
						res2=[[{:text=> res, :align=>:left }]] # datos que se desean en la tabla
						pdf.table res2, # lineas para generar la tabla en el docuemnto
						:border_style => :grid, #:underline_header
						:font_size  => 8, 
						:horizontal_padding => 6,
						:vertical_padding   => 3,
						:border_width => 0.7, 
						:column_widths => { 0 => 520}, 
						:position => :left,
						:align => { 0 => :left}
					end
				else
						res2 =[[{:text => "No hubo." , :aling=> :left}]	] # datos que se desean en la tabla
				
						pdf.table res2,  # lineas para generar la tabla en el docuemnto
						:border_style => :grid, #:underline_header
						:font_size  => 8, 
						:horizontal_padding => 6,
						:vertical_padding   => 3,
						:border_width => 0.7, 
						:column_widths => { 0 => 520}, 
						:position => :left,
						:align => { 0 => :left}
					
				end
									
				res3 = [[{:text=> "4.1.2.- Presentación de ponencias, conferencias y carteles en eventos:\n", :font_style => :bold}]] # datos que se desean en la tabla
				
				pdf.table res3, # lineas para generar la tabla en el docuemnto
				:border_style => :grid, #:underline_header
				:font_size  => 8, 
				:horizontal_padding => 6,
				:vertical_padding   => 3,
				:border_width => 0.7, 
				:column_widths => { 0 => 520}, 
				:position => :left,
				:align => { 0 => :left}
			
				if resultPP !=[]
					resultPP.each do |res|
						res4 = [[{:text=> res, :align=>:left }]] # datos que se desean en la tabla
						pdf.table res4, # lineas para generar la tabla en el docuemnto
						:border_style => :grid, #:underline_header
						:font_size  => 8, 
						:horizontal_padding => 6,
						:vertical_padding   => 3,
						:border_width => 0.7, 
						:column_widths => { 0 => 520}, 
						:position => :left,
						:align => { 0 => :left}
					end
				else
					res4 =[[{:text => "No hubo." , :aling=> :left}]	] # datos que se desean en la tabla
				
					pdf.table res4,  # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
				end
			
				res5 = [[{:text=> "4.1.3.- Otros:\n", :font_style => :bold}]] # datos que se desean en la tabla
				
				pdf.table res5, # lineas para generar la tabla en el docuemnto
				:border_style => :grid, #:underline_header
				:font_size  => 8, 
				:horizontal_padding => 6,
				:vertical_padding   => 3,
				:border_width => 0.7, 
				:column_widths => { 0 => 520}, 
				:position => :left,
				:align => { 0 => :left}
			
			
				if resultO != []
					resultO.each do |res|
						res6 = [[{:text=> res, :align=>:left }]] # datos que se desean en la tabla
						pdf.table res6, # lineas para generar la tabla en el docuemnto
						:border_style => :grid, #:underline_header
						:font_size  => 8, 
						:horizontal_padding => 6,
						:vertical_padding   => 3,
						:border_width => 0.7, 
						:column_widths => { 0 => 520}, 
						:position => :left,
						:align => { 0 => :left}
						
					end
				else
					res6 =[	[{:text => "No hubo." , :aling=> :left}]] # datos que se desean en la tabla
				
					pdf.table res6,  # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
				end
				
				res7 = [[{:text=> "4.1.4.- Asistencia a eventos científicos (Congresos, Seminarios, Coloquios, Jornadas, etc.):\n", :font_style => :bold}]] # datos que se desean en la tabla
				
				pdf.table res7, # lineas para generar la tabla en el docuemnto
				:border_style => :grid, #:underline_header
				:font_size  => 8, 
				:horizontal_padding => 6,
				:vertical_padding   => 3,
				:border_width => 0.7, 
				:column_widths => { 0 => 520}, 
				:position => :left,
				:align => { 0 => :left}
				
				if resultAEC != []
					resultAEC.each do |res|
						res8 = [[{:text=> res, :align=>:left }]] # datos que se desean en la tabla
						pdf.table res8, # lineas para generar la tabla en el docuemnto
						:border_style => :grid, #:underline_header
						:font_size  => 8, 
						:horizontal_padding => 6,
						:vertical_padding   => 3,
						:border_width => 0.7, 
						:column_widths => { 0 => 520}, 
						:position => :left,
						:align => { 0 => :left}
					end
				else
					res8 =[	[{:text => "No hubo." , :aling=> :left}]] # datos que se desean en la tabla
				
					pdf.table res8,  # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
				end
				
				res9 = [[{:text=> "4.1.5.- Organización de eventos científicos (Congresos, Seminarios, Coloquios, Jornadas, etc.):\n", :font_style => :bold}]	] # datos que se desean en la tabla
				
				pdf.table res9, # lineas para generar la tabla en el docuemnto
				:border_style => :grid, #:underline_header
				:font_size  => 8, 
				:horizontal_padding => 6,
				:vertical_padding   => 3,
				:border_width => 0.7, 
				:column_widths => { 0 => 520}, 
				:position => :left,
				:align => { 0 => :left}
				
				if resultOEC != []
					resultOEC.each do |res|
						res10 = [[{:text=> res, :align=>:left }]] # datos que se desean en la tabla
						pdf.table res10, # lineas para generar la tabla en el docuemnto
						:border_style => :grid, #:underline_header
						:font_size  => 8, 
						:horizontal_padding => 6,
						:vertical_padding   => 3,
						:border_width => 0.7, 
						:column_widths => { 0 => 520}, 
						:position => :left,
						:align => { 0 => :left}
					end
				else
					res10 =[[{:text => "No hubo." , :aling=> :left}]] # datos que se desean en la tabla
				 
					pdf.table res10, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
				end
				
				res11 = [[{:text=> "4.1.6.- Dictado de cursos, talleres o seminarios científicos:\n", :font_style => :bold}]] # datos que se desean en la tabla
				
				pdf.table res11, # lineas para generar la tabla en el docuemnto
				:border_style => :grid, #:underline_header
				:font_size  => 8, 
				:horizontal_padding => 6,
				:vertical_padding   => 3,
				:border_width => 0.7, 
				:column_widths => { 0 => 520}, 
				:position => :left,
				:align => { 0 => :left}
				
				if resultDCS != []
					resultDCS.each do |res|
						res12= [[{:text=> res, :align=>:left }]] # datos que se desean en la tabla
						pdf.table res12, # lineas para generar la tabla en el docuemnto
						:border_style => :grid, #:underline_header
						:font_size  => 8, 
						:horizontal_padding => 6,
						:vertical_padding   => 3,
						:border_width => 0.7, 
						:column_widths => { 0 => 520}, 
						:position => :left,
						:align => { 0 => :left}
					end
				else
					res12 =[[{:text => "No hubo." , :aling=> :left}]] # datos que se desean en la tabla
				
					pdf.table res12,  # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 520}, 
					:position => :left,
					:align => { 0 => :left}
				end
				
				
				
			#aparatado 5
			pdf.text("\n")
			pdf.text("5.- ACTIVIDADES DE FORMACIÓN:", :style => :bold, :size  => 10)
			data5 = [[{:text=>"ACTIVIDAD DE FORMACIÓN PROGRAMADA",:align=>:center,:font_style => :bold}, {:text =>"ACTIVIDAD DE FORMACIÓN EJECUTADA", :align=>:center,:font_style => :bold},{:text =>"OBSERVACIONES", :align=>:center,:font_style => :bold} ]	] # datos que se desean en la tabla
			
			pdf.table data5,  # lineas para generar la tabla en el docuemnto
			:border_style => :grid, #:underline_header
			:font_size  => 8, 
			:horizontal_padding => 6,
			:vertical_padding   => 3,
			:border_width => 0.7, 
			:column_widths => { 0 => 173, 1 => 173, 2 => 173}, 
			:position => :left,
			:align => { 0 => :left, 1 => :left, 2=> :left}
			
			if info_formacion != []
				info_formacion.each do |actv|
					ae = InformeActividad.where(actividad_id: actv.id, informe: informe.id).take
					ai = ActividadEjecutada.where(informe_actividad_id: ae.id).take
        			obs= ObservacionTutor.where(informe_actividad_id: ae.id).take
        			if !obs.blank?
        				if !ai.blank?
							data51 = [[{:text=> actv.actividad.to_s, :align=>:left}, {:text => ai.descripcion.to_s, :align=>:left}, {:text => obs.observaciones.to_s, :align=>:left}]] # datos que se desean en la tabla
						else
							data51 = [[{:text=> actv.actividad.to_s, :align=>:left}, {:text => "", :align=>:left}, {:text => obs.observaciones.to_s, :align=>:left}]] # datos que se desean en la tabla
						end
					else
						if !ai.blank?
							data51 = [[{:text=> actv.actividad.to_s, :align=>:left}, {:text => ai.descripcion.to_s, :align=>:left}, {:text => "", :align=>:left}]] # datos que se desean en la tabla
						else
							data51 = [[{:text=> actv.actividad.to_s, :align=>:left}, {:text => "", :align=>:left}, {:text => "", :align=>:left}]] # datos que se desean en la tabla
						end
					end
					pdf.table data51,  # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 173, 1 => 173, 2 => 173}, 
					:position => :left,
					:align => { 0 => :left, 1 => :left, 2=> :left}
					
				end
			else
				data51=[[{:text=> "No hubo.", :align=>:left}, {:text => "", :align=>:left}, {:text => "", :align=>:left}]] # datos que se desean en la tabla
					pdf.table data51, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 173, 1 => 173, 2 => 173}, 
					:position => :left,
					:align => { 0 => :left, 1 => :left, 2=> :left}
			end
			
			#data52=[[{:text=> "5.1.- Grado de avance en los estudios de postgrado:\n", :font_style => :bold}],
			#[{:text=> informe.avance.to_s, :align=>:left}]] # datos que se desean en la tabla
			
			pdf.text("\n")

			pdf.text("6.- ACTIVIDADES DE EXTENSIÓN:", :style => :bold, :size  => 10)
			data6 = [[{:text=>"ACTIVIDAD DE EXTENSIÓN PROGRAMADA",:align=>:center,:font_style => :bold}, {:text =>"ACTIVIDAD DE EXTENSIÓN EJECUTADA", :align=>:center,:font_style => :bold},{:text =>"OBSERVACIONES", :align=>:center,:font_style => :bold} ]	] # datos que se desean en la tabla
			
			pdf.table data6,  # lineas para generar la tabla en el docuemnto
			:border_style => :grid, #:underline_header
			:font_size  => 8, 
			:horizontal_padding => 6,
			:vertical_padding   => 3,
			:border_width => 0.7, 
			:column_widths => { 0 => 173, 1 => 173, 2 => 173}, 
			:position => :left,
			:align => {0 => :left, 1 => :left, 2=> :left}
			
			if info_extension != []
				info_extension.each do |actv|
					ae = InformeActividad.where(actividad_id: actv.id, informe: informe.id).take
					ai = ActividadEjecutada.where(informe_actividad_id: ae.id).take
        			obs= ObservacionTutor.where(informe_actividad_id: ae.id).take
        			if !obs.blank?
        				if !ai.blank?
							data61 = [[{:text=> actv.actividad.to_s, :align=>:left}, {:text => ai.descripcion.to_s, :align=>:left}, {:text => obs.observaciones.to_s, :align=>:left}]] # datos que se desean en la tabla
						else
							data61 = [[{:text=> actv.actividad.to_s, :align=>:left}, {:text => "", :align=>:left}, {:text => obs.observaciones.to_s, :align=>:left}]] # datos que se desean en la tabla
						end
					else
						if !ai.blank?
							data61 = [[{:text=> actv.actividad.to_s, :align=>:left}, {:text => ai.descripcion.to_s, :align=>:left}, {:text => "", :align=>:left}]] # datos que se desean en la tabla
						else
							data61 = [[{:text=> actv.actividad.to_s, :align=>:left}, {:text => "", :align=>:left}, {:text => "", :align=>:left}]] # datos que se desean en la tabla
						end
					end
					pdf.table data61, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 173, 1 => 173, 2 => 173}, 
					:position => :left,
					:align => { 0 => :left, 1 => :left, 2=> :left}
					
				end
			else
				data61=[[{:text=> "No hubo.", :align=>:left}, {:text => "", :align=>:left}, {:text => "", :align=>:left}]] # datos que se desean en la tabla
				pdf.table data61, # lineas para generar la tabla en el docuemnto
				:border_style => :grid, #:underline_header
				:font_size  => 8, 
				:horizontal_padding => 6,
				:vertical_padding   => 3,
				:border_width => 0.7, 
				:column_widths => { 0 => 173, 1 => 173, 2 => 173}, 
				:position => :left,
				:align => { 0 => :left, 1 => :left, 2=> :left}
			end

			x=7

			if tipo_informe.tipo=="Final"
				pdf.text("\n")

				pdf.text(x.to_s+".- ACTIVIDADES PARA LA APROBACIÓN:", :style => :bold, :size  => 10)
				data6 = [[{:text=>"ACTIVIDAD PARA LA APROBACIÓN",:align=>:center,:font_style => :bold}, {:text =>"ACTIVIDAD PARA LA APROBACIÓN EJECUTADA", :align=>:center,:font_style => :bold},{:text =>"OBSERVACIONES", :align=>:center,:font_style => :bold} ]	] # datos que se desean en la tabla
				
				pdf.table data6,  # lineas para generar la tabla en el docuemnto
				:border_style => :grid, #:underline_header
				:font_size  => 8, 
				:horizontal_padding => 6,
				:vertical_padding   => 3,
				:border_width => 0.7, 
				:column_widths => { 0 => 173, 1 => 173, 2 => 173}, 
				:position => :left,
				:align => {0 => :left, 1 => :left, 2=> :left}
				
				if actividadesaobli != []
					actividadesaobli.each do |actv|
						ae = InformeActividad.where(actividad_id: actv.id, informe: informe.id).take
						ai = ActividadEjecutada.where(informe_actividad_id: ae.id).take
	        			obs= ObservacionTutor.where(informe_actividad_id: ae.id).take
	        			if !obs.blank?
	        				if !ai.blank?
								data61 = [[{:text=> actv.actividad.to_s, :align=>:left}, {:text => ai.descripcion.to_s, :align=>:left}, {:text => obs.observaciones.to_s, :align=>:left}]] # datos que se desean en la tabla
							else
								data61 = [[{:text=> actv.actividad.to_s, :align=>:left}, {:text => "", :align=>:left}, {:text => obs.observaciones.to_s, :align=>:left}]] # datos que se desean en la tabla
							end
						else
							if !ai.blank?
								data61 = [[{:text=> actv.actividad.to_s, :align=>:left}, {:text => ai.descripcion.to_s, :align=>:left}, {:text => "", :align=>:left}]] # datos que se desean en la tabla
							else
								data61 = [[{:text=> actv.actividad.to_s, :align=>:left}, {:text => "", :align=>:left}, {:text => "", :align=>:left}]] # datos que se desean en la tabla
							end
						end
						pdf.table data61, # lineas para generar la tabla en el docuemnto
						:border_style => :grid, #:underline_header
						:font_size  => 8, 
						:horizontal_padding => 6,
						:vertical_padding   => 3,
						:border_width => 0.7, 
						:column_widths => { 0 => 173, 1 => 173, 2 => 173}, 
						:position => :left,
						:align => { 0 => :left, 1 => :left, 2=> :left}
						
					end
				else
					data61=[[{:text=> "No hubo.", :align=>:left}, {:text => "", :align=>:left}, {:text => "", :align=>:left}]] # datos que se desean en la tabla
					pdf.table data61, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8, 
					:horizontal_padding => 6,
					:vertical_padding   => 3,
					:border_width => 0.7, 
					:column_widths => { 0 => 173, 1 => 173, 2 => 173}, 
					:position => :left,
					:align => { 0 => :left, 1 => :left, 2=> :left}
				end
				x=x+1
			end
			
			pdf.text("\n")
			
			#APARTADO 7
			
			pdf.text(x.to_s+".- OTRAS ACTIVIDADES: \n", :style => :bold, :size  => 10)
			data7 = [[{:text=>"CONTEMPLADAS EN EL PLAN DE FORMACIÓN Y CAPACITACIÓN:",:align=>:center,:font_style => :bold}, {:text =>"NO CONTEMPLADAS EN EL PLAN DE FORMACIÓN Y CAPACITACIÓN", :align=>:center,:font_style => :bold}]] # datos que se desean en la tabla
			
			pdf.table data7,  # lineas para generar la tabla en el docuemnto
			:border_style => :grid, #:underline_header
			:font_size  => 8, 
			:horizontal_padding => 6,
			:vertical_padding   => 2,
			:border_width => 0.7, 
			:column_widths => { 0 => 259, 1 => 259}, 
			:position => :left,
			:align => {0 => :left, 1 => :left}
			if info_otras != []
				info_otras.each do |actv|
					ae = InformeActividad.where(actividad_id: actv.id, informe: informe.id).take
					ai = ActividadEjecutada.where(informe_actividad_id: ae.id).take
					if ai
						data71 = [[{:text=> actv.actividad.to_s, :align=>:left}, {:text => ai.descripcion.to_s, :align=>:left}]] # datos que se desean en la tabla
					else
						data71 = [[{:text=> actv.actividad.to_s, :align=>:left}, {:text => "" , :align=>:left}]] # datos que se desean en la tabla
					end
					pdf.table data71, # lineas para generar la tabla en el docuemnto
					:border_style => :grid, #:underline_header
					:font_size  => 8, 
					:horizontal_padding => 6,
					:vertical_padding   => 2,
					:border_width => 0.7, 
					:column_widths => { 0 => 259, 1 => 259}, 
					:position => :left,
					:align => {0 => :left, 1 => :left}
				end
			else
				data71=[[{:text=> "No hubo.", :align=>:left}, {:text => "", :align=>:left}]] # datos que se desean en la tabla
				pdf.table data71, # lineas para generar la tabla en el docuemnto
				:border_style => :grid, #:underline_header
				:font_size  => 8, 
				:horizontal_padding => 6,
				:vertical_padding   => 2,
				:border_width => 0.7, 
				:column_widths => { 0 => 259, 1 => 259}, 
				:position => :left,
				:align => {0 => :left, 1 => :left}
			end
			x=x+1
			pdf.text("\n")
			
			#aparatdo 8
			punto='. '
			pdf.text(x.to_s+".- CONCLUSIONES:", :style => :bold, :size  => 10)
			

			if !informe.conclusiones.blank?
				data10 = [[{:text=> informe.conclusiones.to_s, :align=> :left}]] # datos que se desean en la tabla
				
				pdf.table data10, # lineas para generar la tabla en el docuemnto
				:border_style => :grid, #:underline_header
				:font_size  => 8, 
				:horizontal_padding => 6,
				:vertical_padding   => 3,
				:border_width => 0.7, 
				:column_widths => { 0 => 520}, 
				:position => :left,
				:align => { 0 => :left}
				
			else
				data10 = [[{:text=> " ", :align=> :left}]] # datos que se desean en la tabla
				
				pdf.table data10, # lineas para generar la tabla en el docuemnto
				:border_style => :grid, #:underline_header
				:font_size  => 8, 
				:horizontal_padding => 6,
				:vertical_padding   => 3,
				:border_width => 0.7, 
				:column_widths => { 0 => 520}, 
				:position => :left,
				:align => { 0 => :left}
			end
			
			pdf.text("\n")
			x=x+1
			
			#aparatdo 9
			
			pdf.text(x.to_s+".- OPINIÓN DEL TUTOR:", :style => :bold, :size  => 10)
			
			if !informe.opinion_tutor.blank?
				data11 = [[{:text=> informe.opinion_tutor.to_s, :align=> :left}]] # datos que se desean en la tabla
				
				pdf.table data11, # lineas para generar la tabla en el docuemnto
				:border_style => :grid, #:underline_header
				:font_size  => 8, 
				:horizontal_padding => 6,
				:vertical_padding   => 3,
				:border_width => 0.7, 
				:column_widths => { 0 => 520}, 
				:position => :left,
				:align => { 0 => :left}
				
			else
				data11 = [[{:text=> " ", :align=> :left}]] # datos que se desean en la tabla
				
				pdf.table data11, # lineas para generar la tabla en el docuemnto
				:border_style => :grid, #:underline_header
				:font_size  => 8, 
				:horizontal_padding => 6,
				:vertical_padding   => 3,
				:border_width => 0.7, 
				:column_widths => { 0 => 520}, 
				:position => :left,
				:align => { 0 => :left}
			end
			
						
			x=x+1
			pdf.text("\n")
			pdf.text(x.to_s+".- JUSTIFICACIONES:", :style => :bold, :size  => 10)
			
			if !informe.justificaciones.blank?
				data112 = [[{:text=> informe.justificaciones.to_s, :align=> :left}]] # datos que se desean en la tabla
				
				pdf.table data112, # lineas para generar la tabla en el docuemnto
				:border_style => :grid, #:underline_header
				:font_size  => 8, 
				:horizontal_padding => 6,
				:vertical_padding   => 3,
				:border_width => 0.7, 
				:column_widths => { 0 => 520}, 
				:position => :left,
				:align => { 0 => :left}
				
			else
				data112 = [[{:text=> " ", :align=> :left}]] # datos que se desean en la tabla
				
				pdf.table data112, # lineas para generar la tabla en el docuemnto
				:border_style => :grid, #:underline_header
				:font_size  => 8, 
				:horizontal_padding => 6,
				:vertical_padding   => 3,
				:border_width => 0.7, 
				:column_widths => { 0 => 520}, 
				:position => :left,
				:align => { 0 => :left}
			end
			
						
			#FIN DEL INFORME		
			
			
			pdf.text("\n")
			data12 = [
				[{:text=>"Firma del Tutor: \n", :font_style => :bold}, {:text => 'Fecha:', :align=>:left,  :font_style => :bold} ],
				[{:text=>"Adecuación del Plan de Formación y Capacitación Aprobado por el Consejo de Escuela o Instituto en Sesión de Fecha: \n",  :font_style => :bold}, {:text => 'Adecuación del Plan de Formación y Capacitación Aprobado por el Consejo de la Facultad de Ciencias en Sesión de Fecha:', :align=>:left,  :font_style => :bold} ]] # cuadro final del documento
		  
			pdf.table data12, # lineas para generar la tabla en el docuemnto
			:border_style => :grid, #:underline_header
			:font_size  => 8, 
			:horizontal_padding => 6,
			:vertical_padding   => 15,
			:border_width => 0.7, 
			:column_widths => {0 => 260, 1=>260}, 
			:position => :left,
			:align => {0 => :left, 1=> :left}

			@i = documents.size
			pdf.text("\n")
			pdf.text("Cantidad de soportes adjuntos:"+ @i.to_s+" \n", :style => :bold, :size  => 10)
			
			
		end
		#####################+
		fechaActual = Date.current.to_s
		if numeroDeVersion == nil
   			nombre_archivo= instructor.ci.to_s+'-'+fechaActual+'-informe.pdf' # se arma el nombre del documento 
		else
   			nombre_archivo= instructor.ci.to_s+'-'+fechaActual+'-informeV'+numeroDeVersion.to_s+'.pdf' # se arma el nombre del documento 
		end
		url = "#{Rails.root}/tmp/PDFs/" + nombre_archivo
		pdf.render_file(url) # creación del docuemnto bajo su nombre
		return nombre_archivo
	end
end