class Resultado < ActiveRecord::Base
	belongs_to :actividad
	belongs_to :tipo_resultado
	belongs_to :informe_actividad
end