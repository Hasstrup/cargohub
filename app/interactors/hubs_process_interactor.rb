# helps format input from csv and persist to db
class HubsProcessInteractor
  include Interactor

  def call
    batch = context.batch
    countries_batch = [*batch].keep_if { |item| item.compact.size == 2 }
    hubs_batch = batch - countries_batch

    countries_input = countries_batch.map do |country_item|
      build_attributes_for_country(country_item)
    end

    hubs_input = hubs_batch.map do |hub_item|
      build_attributes_for_hub(hub_item)
    end

    persist_to_db(countries_input, hubs_input)
  end

  private

  def build_attributes_for_hub(input)
    input = input.drop(1)
    locode = "#{input.first} #{input[1]}"
    {
      locode: locode,
      name: input[2],
      country_symbol: input.first,
      function: input[5],
      status: input[6],
      coordinates: coordinates_for(input[9])
    }
  end

  def build_attributes_for_country(input)
    {
      symbol: input.compact.first,
      name: input.compact[1].delete('.')
    }
  end

  def lat(coords)
    return '' if coords.nil?
    deg = coords.slice(0..2)
    minutes = coords.slice(3..4)
    sign = coords[coords.length] == 'W' ? '-' : '+'
    "#{sign}#{deg}.#{(minutes.to_f / 60).to_s.slice(2..10)}"
  end

  def long(coords)
    return '' if coords.nil?
    deg = coords.slice(0..1)
    minutes = coords.slice(2..3)
    sign = coords[coords.length] == 'S' ? '-' : '+'
    "#{sign}#{deg}.#{(minutes.to_f / 60).to_s.slice(2..10)}"
  end

  def coordinates_for(dms_coords)
    return nil if dms_coords.nil?
    coords_array = dms_coords.split(' ')
    "#{lat(coords_array.last)}, #{long(coords_array.first)}"
  end

  def persist_to_db(countries, hubs)
    Country.import(countries)
    Hub.import(hubs)
  end
end
