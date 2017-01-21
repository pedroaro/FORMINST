class Adecuacionactividad < ActiveRecord::Base
	belongs_to :adecuacion
	has_many :observacionesactividadadecuacion
	belongs_to :actividad
end