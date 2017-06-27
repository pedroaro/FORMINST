class CreateDocumentoPlan < ActiveRecord::Migration
  def change
    create_table :documento_plan do |t|

      t.timestamps
    end
  end
end
