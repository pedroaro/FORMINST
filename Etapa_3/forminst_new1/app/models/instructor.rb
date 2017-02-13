class Instructor < ActiveRecord::Base
	belongs_to :usuario

	def self.md5(clave) # función que permite encriptar las claves a MD5
		Digest::MD5.hexdigest("#{clave}")
	end
end
