class CreateDocumentoInforme < ActiveRecord::Migration
  def change
    create_table :documento_informe do |t|

      t.timestamps
    end
  end
end
