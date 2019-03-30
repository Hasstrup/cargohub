class AddColumnsToHubs < ActiveRecord::Migration[5.1]
  def change
    add_column :hubs, :country_symbol, :string, index: true
    add_column :hubs, :status, :string
    add_column :hubs, :coordinates, :string
    remove_column :hubs, :latitude
    remove_column :hubs, :longitude
    remove_column :hubs, :routes_id

    # drop the routes table
    drop_table :routes
  end
end
