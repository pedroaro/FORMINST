class ActionCorreo < ActionMailer::Base
  	default from: "FORMINST"

  	def envio_informe(email)
  		@email= email
		@user_email = 'forminst.ciens@gmail.com'
		mail(to: [@user_email,@email], subject: 'PRUEBA FORMINST')
	end

	def envio_adecuacion(email)
  		@email= email
		@user_email = 'forminst.ciens@gmail.com'
		mail(to: [@user_email,@email], subject: 'PRUEBA FORMINST')
	end
end