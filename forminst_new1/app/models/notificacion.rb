class Notificacion < ActiveRecord::Base
	has_many :usuario
	has_one :adecuacion
	has_one :informe
end
