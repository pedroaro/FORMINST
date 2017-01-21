class Estatusadecuacion < ActiveRecord::Base
	belongs_to :adecuacion
	belongs_to :tipoestatus
end