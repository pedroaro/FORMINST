class Tipoactividad < ActiveRecord::Base
	has_many :actividad
	has_many :tiporesultado
end