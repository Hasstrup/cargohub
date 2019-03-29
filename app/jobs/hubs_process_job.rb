# takes in classes in batches and persists them to the database
class HubsProcessJob < ApplicationJob
  def perfrom(batch)
    # batch is an array of arrays
  end

  private

  def lat(coords)
    deg = coords.slice(0..2)
    minutes = coords.slice(3..4)
    sign = coords[coords.length] == 'W' ? '-' : '+'
    "#{sign} #{deg}.#{(minutes.to_f / 60).to_s.slice(2..10)}"
  end

  def long(coords)
    deg = coords.slice(0..1)
    minutes = coords.slice(2..3)
    sign = coords[coords.length] == 'S' ? '-' : '+'
    "#{sign}#{deg}.#{(minutes.to_f / 60).to_s.slice(2..10)}"
  end

  def coordinates_for(dms_coords)
    coords_array = dms_coords.split(' ')
    "#{long(coords_array.first)}, #{lat(coords_array.last)}"
  end
end
