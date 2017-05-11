class ActionCorreo < ActionMailer::Base
  	default from: "FORMINST"

  	def envio_informe_a_entidad(remitente, mensaje)
  		@mensaje = mensaje
  		email = remitente.user + "@ciens.ucv.ve"
  		@email= email
		@user_email = 'forminst.ciens@gmail.com'
		mail(to: [@user_email,@email], subject: 'Ha recibido un nuevo Informe')
	end

	def envio_adecuacion(email)
  		@email= email
		@user_email = 'forminst.ciens@gmail.com'
		mail(to: [@user_email,@email], subject: 'PRUEBA FORMINST')
	end
end