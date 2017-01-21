class Usuario < ActiveRecord::Base
	has_many :usuarioentidad
	has_many :permisologium
	has_one :persona
	#has_many :planformacion
	#has_many :adecuacion
	#has_many :informe
end