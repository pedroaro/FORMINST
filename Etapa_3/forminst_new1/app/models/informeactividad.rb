class Informeactividad < ActiveRecord::Base
	belongs_to :informe
	has_many :documento
	has_many :observacionesactividadinforme
	has_many :actividadejecutada
	has_many :observaciontutor
	belongs_to :actividad
	has_many :resultado
end