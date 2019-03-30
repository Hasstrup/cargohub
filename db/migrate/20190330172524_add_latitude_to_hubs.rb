class AddLatitudeToHubs < ActiveRecord::Migration[5.1]
  def change
    add_column :hubs, :latitude, :decimal
    add_column :hubs, :longitude, :decimal
    add_column :hubs, :address, :string
  end
end
