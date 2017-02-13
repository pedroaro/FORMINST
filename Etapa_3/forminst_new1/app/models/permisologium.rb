class Permisologium < ActiveRecord::Base
	belongs_to :usuario
	belongs_to :permiso
end