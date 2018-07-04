class ActionCorreo < ActionMailer::Base
  	default from: "FORMINST"

  	def envio_informe(remitente, mensaje, id, link,document) ##ID :: 0 = ENTIDAD, 1 = INSTRUCTOR, 2 T= TUTOR
  		@id = id
  		@mensaje = mensaje
		  if remitente.to_s.include? "@gmail.com"
			email = remitente
		else
			email = remitente.user + "@ciens.ucv.ve"
		end  		@email= email
		@user_email = 'forminst.ciens@gmail.com'
		@link = link
		attachments[document.filename] = document.file_contents		
		if (id == 0	&& !(remitente.to_s.include? "@gmail.com"))	##ENTIDAD
			uEntidad = Usuarioentidad.where(usuario_id: remitente.id).take
			pertenecientes = Aenviar.where(entidad_id: uEntidad.entidad_id)
			nombreEntidad = Entidad.find(uEntidad.entidad_id).nombre
			pertenecientes.each do |email|
				mail(to: [@user_email,email], subject: nombreEntidad + ': Ha recibido una nueva Adecuación')
			end
			mail(to: [@user_email,@email], subject: 'Ha recibido un nuevo Informe')
		else			##TUTOR O INSTRUCTOR
			mail(to: [@user_email,@email], subject: 'Avance de Informe')
		end
	end

	def envio_adecuacion(remitente, mensaje, id, link,document)
  		@id = id
		@mensaje = mensaje
		if remitente.to_s.include? "@gmail.com"
			email = remitente
		else
			email = remitente.user + "@ciens.ucv.ve"
		end
  		@email= email
		@user_email = 'forminst.ciens@gmail.com'
		@link = link
		attachments[document.filename] = document.file_contents				
		if (id == 0	&& !(remitente.to_s.include? "@gmail.com"))		##ENTIDAD
			uEntidad = Usuarioentidad.where(usuario_id: remitente.id).take
			pertenecientes = Aenviar.where(entidad_id: uEntidad.entidad_id)
			nombreEntidad = Entidad.find(uEntidad.entidad_id).nombre
			pertenecientes.each do |email|
				mail(to: [@user_email,email], subject: nombreEntidad + ': Ha recibido una nueva Adecuación')
			end
			mail(to: [@user_email,@email], subject: 'Ha recibido una nueva Adecuación')
		else			##TUTOR O INSTRUCTOR
			mail(to: [@user_email,@email], subject: 'Avance de Adecuación')
		end
	end

	def retraso_informe(remitente, mensaje, link)
  		@mensaje = mensaje
  		email = remitente.user + "@ciens.ucv.ve"
  		@email= email
		@user_email = 'forminst.ciens@gmail.com'
		@link = link
		mail(to: [@user_email,@email], subject: 'Recordatorio de envío de informe')
	end

	def creacion_de_instructor(remitente, mensaje, id, link)
  		@id = id
  		@mensaje = mensaje
  		email = remitente.user + "@ciens.ucv.ve"
  		@email= email
		@user_email = 'forminst.ciens@gmail.com'
		@link = link
		if id == 0		##INSTRUCTOR
			mail(to: [@user_email,@email], subject: '¡Bienvenido a FORMINST!')
		else			##TUTOR
			mail(to: [@user_email,@email], subject: 'Nueva Asignación de Instructor')
		end
	end

	def creacion_de_tutor(remitente, mensaje)
  		@mensaje = mensaje
  		email = remitente.user + "@ciens.ucv.ve"
  		@email= email
		@link = "http://formacion.ciens.ucv.ve"
		@user_email = 'forminst.ciens@gmail.com'
		mail(to: [@user_email,@email], subject: '¡Bienvenido a FORMINST!')
	end
end
