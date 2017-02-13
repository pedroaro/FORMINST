class Informe < ActiveRecord::Base
	belongs_to :usuario
	belongs_to :planformacion
	has_many :estatusinforme
	has_many :revision
	has_many :informeactividad
	has_many :documentoinforme
	belongs_to :tipo_informe
end