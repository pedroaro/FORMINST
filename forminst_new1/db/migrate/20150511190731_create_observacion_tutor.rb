class CreateObservacionTutor < ActiveRecord::Migration
  def change
    create_table :observacion_tutor do |t|

      t.timestamps
    end
  end
end
