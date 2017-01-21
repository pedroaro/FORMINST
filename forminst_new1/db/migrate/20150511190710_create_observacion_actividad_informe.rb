class CreateObservacionActividadInforme < ActiveRecord::Migration
  def change
    create_table :observacion_actividad_informe do |t|

      t.timestamps
    end
  end
end
