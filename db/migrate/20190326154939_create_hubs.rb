class CreateHubs < ActiveRecord::Migration[5.1]
  def change
    create_table :hubs do |t|
      t.string :name
      t.string :locode
      t.decimal :latitude
      t.decimal :longitude
      t.string :function
      t.references :routes, index: true
      t.timestamps
    end
  end
end
