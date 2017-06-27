class CreateAdecuacionActividad < ActiveRecord::Migration
  def change
    create_table :adecuacion_actividad do |t|

      t.timestamps
    end
  end
end
