class Revision < ActiveRecord::Base
	belongs_to :tipo_estatus
	belongs_to :informe
	has_many :observacion_actividadad_adecuacion
	belongs_to :adecuacion
	has_many :observacion_actividad_informe
end