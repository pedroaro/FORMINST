class CreateEstatusInforme < ActiveRecord::Migration
  def change
    create_table :estatus_informe do |t|

      t.timestamps
    end
  end
end
