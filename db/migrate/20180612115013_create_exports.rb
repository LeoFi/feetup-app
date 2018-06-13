class CreateExports < ActiveRecord::Migration[5.2]
  def change
    create_table :exports do |t|
      t.timestamps

      t.references :shop, foreign_key: true
      t.string :name, null: false
      t.string :time, null: false
    end
  end
end
