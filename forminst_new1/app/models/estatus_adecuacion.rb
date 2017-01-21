class EstatusAdecuacion < ActiveRecord::Base
	belongs_to :adecuacion
	belongs_to :tipo_estatus
end
