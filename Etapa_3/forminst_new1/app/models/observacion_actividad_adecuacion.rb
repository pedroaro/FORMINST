class ObservacionActividadAdecuacion < ActiveRecord::Base
	belongs_to :revision
	belongs_to :adecuacion_actividad
end
