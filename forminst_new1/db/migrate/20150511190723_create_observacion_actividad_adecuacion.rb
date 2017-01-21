class CreateObservacionActividadAdecuacion < ActiveRecord::Migration
  def change
    create_table :observacion_actividad_adecuacion do |t|

      t.timestamps
    end
  end
end
