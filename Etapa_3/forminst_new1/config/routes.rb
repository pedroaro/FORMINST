Rails.application.routes.draw do

	post 'iniciotutor/ver_detalles_plan', to: 'iniciotutor#ver_detalles_plan'
	get 'adecuacions/descargar_pdf', to: 'adecuacions#descargar_pdf'
	get ':controller(/:action(/:id(.:format)))'
  	post ':controller(/:action(/:id(.:format)))'
  	root 'forminst#index'

end
