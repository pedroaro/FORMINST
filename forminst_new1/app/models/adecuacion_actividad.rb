class AdecuacionActividad < ActiveRecord::Base
	belongs_to :adecuacion
	has_many :observacion_actividadad_adecuacion
	belongs_to :actividad
end
