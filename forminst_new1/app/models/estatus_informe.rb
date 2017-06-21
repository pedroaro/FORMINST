class EstatusInforme < ActiveRecord::Base
	belongs_to :informe
	belongs_to :tipo_estatus
end
