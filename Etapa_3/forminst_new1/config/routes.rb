Rails.application.routes.draw do

  get 'download/index'

  get 'home/download/pdf'

	post 'iniciotutor/ver_detalles_plan', to: 'iniciotutor#ver_detalles_plan'
	get 'adecuacions/descargar_pdf', to: 'adecuacions#descargar_pdf'
	get ':controller(/:action(/:id(.:format)))'
  	post ':controller(/:action(/:id(.:format)))'
  	root 'forminst#index'
  	root 'download#index'

end
