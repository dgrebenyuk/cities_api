class CreateCities < ActiveRecord::Migration[5.2]
  def change
    create_table :cities do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.bigint :population, null: false

      t.decimal :latitude
      t.decimal :longitude

      t.timestamps
    end

    add_index :cities, :name
  end
end
