class Observacionesactividadadecuacion < ActiveRecord::Base
	belongs_to :revision
	belongs_to :adecuacionactividad
end