class CreateInformeActividad < ActiveRecord::Migration
  def change
    create_table :informe_actividad do |t|

      t.timestamps
    end
  end
end
