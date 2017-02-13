class CreateTipoEstatus < ActiveRecord::Migration
  def change
    create_table :tipo_estatus do |t|

      t.timestamps
    end
  end
end
