class Planformacion < ActiveRecord::Base
	belongs_to :usuario
	has_many :adecuacion
	has_many :prorroga
	has_many :informe
	has_many :documento_plan
end