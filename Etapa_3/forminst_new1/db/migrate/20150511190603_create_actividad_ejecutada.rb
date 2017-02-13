class CreateActividadEjecutada < ActiveRecord::Migration
  def change
    create_table :actividad_ejecutada do |t|

      t.timestamps
    end
  end
end
