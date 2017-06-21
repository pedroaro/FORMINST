class TipoEstatus < ActiveRecord::Base
	has_many :estatus_informe
	has_many :estatus_adecuacion
	has_many :revision
end
