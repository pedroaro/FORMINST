class CreateTipoResultado < ActiveRecord::Migration
  def change
    create_table :tipo_resultado do |t|

      t.timestamps
    end
  end
end
