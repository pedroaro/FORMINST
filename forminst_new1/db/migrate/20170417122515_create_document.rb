class CreateDocument < ActiveRecord::Migration[5.0]
  def change
    create_table :document do |t|
      t.string :filename
      t.string :content_type
      t.binary :file_contents

      t.timestamps
    end
  end
end
