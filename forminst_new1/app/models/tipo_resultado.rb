class TipoResultado < ActiveRecord::Base
	belongs_to :tipo_actividad
	has_one :resultado
end
