class CreateEstatusAdecuacion < ActiveRecord::Migration
  def change
    create_table :estatus_adecuacion do |t|

      t.timestamps
    end
  end
end
