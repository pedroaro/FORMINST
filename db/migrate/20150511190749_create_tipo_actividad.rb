class CreateTipoActividad < ActiveRecord::Migration
  def change
    create_table :tipo_actividad do |t|

      t.timestamps
    end
  end
end
