class Resultado < ActiveRecord::Base
	belongs_to :actividad
	belongs_to :tipo_resultado
	has_one :informe_actividad
end