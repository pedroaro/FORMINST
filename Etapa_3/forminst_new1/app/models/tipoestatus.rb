class Tipoestatus < ActiveRecord::Base
	has_many :estatusinforme
	has_many :estatusadecuacion
	has_many :revision
end