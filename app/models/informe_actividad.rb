class InformeActividad < ActiveRecord::Base
	belongs_to :informe
	has_many :documento
	has_many :observacion_actividad_informe
	has_many :actividad_ejecutada
	has_many :observacion_tutor
	belongs_to :actividad
	has_many :resultado
end
