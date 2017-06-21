class Adecuacion < ActiveRecord::Base
	belongs_to :usuario
	belongs_to :planformacion
	has_many :estatus_adecuacion
	has_many :revision
	has_many :adecuacion_actividad
end