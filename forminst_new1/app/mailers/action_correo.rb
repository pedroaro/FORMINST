class ActionCorreo < ActionMailer::Base
  	default from: "FORMINST"

  	def envio_informe(remitente, mensaje, id) ##ID :: 0 = ENTIDAD, 1 = INSTRUCTOR, 2 T= TUTOR
  		@id = id
  		@mensaje = mensaje
  		email = remitente.user + "@ciens.ucv.ve"
  		@email= email
		@user_email = 'forminst.ciens@gmail.com'
		if id == 0		##ENTIDAD
			mail(to: [@user_email,@email], subject: 'Ha recibido un nuevo Informe')
		else			##TUTOR O INSTRUCTOR
			mail(to: [@user_email,@email], subject: 'Avance de Informe')
		end
	end

	def envio_adecuacion(remitente, mensaje, id)
  		@id = id
  		@mensaje = mensaje
  		email = remitente.user + "@ciens.ucv.ve"
  		@email= email
		@user_email = 'forminst.ciens@gmail.com'
		if id == 0		##ENTIDAD
			mail(to: [@user_email,@email], subject: 'Ha recibido una nueva Adecuación')
		else			##TUTOR O INSTRUCTOR
			mail(to: [@user_email,@email], subject: 'Avance de Adecuación')
		end
	end

	def creacion_de_instructor(remitente, mensaje, id)
  		@id = id
  		@mensaje = mensaje
  		email = remitente.user + "@ciens.ucv.ve"
  		@email= email
		@user_email = 'forminst.ciens@gmail.com'
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
		@user_email = 'forminst.ciens@gmail.com'
		mail(to: [@user_email,@email], subject: '¡Bienvenido a FORMINST!')
	end
end
