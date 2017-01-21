class Estatusinforme < ActiveRecord::Base
	belongs_to :informe
	belongs_to :tipoestatus
end