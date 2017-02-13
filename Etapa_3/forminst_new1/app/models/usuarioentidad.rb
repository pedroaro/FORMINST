class Usuarioentidad < ActiveRecord::Base
	belongs_to :entidad
	belongs_to :usuario
end