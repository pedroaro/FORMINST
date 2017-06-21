class TipoActividad < ActiveRecord::Base
	has_many :actividad
	has_many :tipo_resultado
end
