class CreateFavourites < ActiveRecord::Migration[5.2]
  def change
    create_table :favourites do |t|
      t.belongs_to :city, index: true
      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
