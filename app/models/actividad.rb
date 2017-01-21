class Actividad < ActiveRecord::Base
	has_many :informe_actividad
	has_many :adecuacion_actividad
	belongs_to :tipo_actividad
	has_one :resultado
end