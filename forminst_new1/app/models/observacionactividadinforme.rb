class Observacionesactividadinforme < ActiveRecord::Base
	belongs_to :informeactividad
	belongs_to :revision
end