class CreateArea < ActiveRecord::Migration
  def change
    create_table :area do |t|

      t.timestamps
    end
  end
end
