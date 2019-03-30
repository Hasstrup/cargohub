class CreateCountries < ActiveRecord::Migration[5.1]
  def change
    create_table :countries do |t|
      t.string :symbol, index: true
      t.string :name
    end
  end
end
