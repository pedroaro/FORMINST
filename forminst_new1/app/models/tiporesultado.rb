class Tiporesultado < ActiveRecord::Base
	belongs_to :tipoactividad
	has_one :resultado
end
