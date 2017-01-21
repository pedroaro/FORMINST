class ObservacionActividadInforme < ActiveRecord::Base
	belongs_to :informe_actividad
	belongs_to :revision
end
