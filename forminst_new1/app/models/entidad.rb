class Entidad < ActiveRecord::Base
	belongs_to :usuario
	belongs_to :escuela

	has_many :usuarioentidad
end