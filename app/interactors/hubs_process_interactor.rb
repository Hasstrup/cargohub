require 'pusher'

# helps format input from csv and persist to db
class HubsProcessInteractor
  include Interactor

  after :send_client_updates

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
  rescue StandardError => error
    context.fail!(errors: error)
  end

  private

  def build_attributes_for_hub(input)
    input.shift
    locode = "#{input.first} #{input[1]}"
    coordinates_for(input[9]).merge(locode: locode,
                                    name: input[2],
                                    country_symbol: input.first,
                                    function: input[5],
                                    status: input[6])
  end

  def build_attributes_for_country(input)
    {
      symbol: input.compact.first,
      name: input.compact[1].delete('.')
    }
  end

  def lat(coords)
    return '' if coords.nil?
    deg = coords.slice(0..1)
    minutes = coords.slice(2..3)
    west = coords[coords.length - 1] == 'S'
    value = "#{deg}.#{(minutes.to_f / 60).to_s.slice(2..10)}"
    west ? value.to_f * -1.0 : value.to_f
  end

  def long(coords)
    return '' if coords.nil?
    deg = coords.slice(0..2)
    minutes = coords.slice(3..4)
    south = coords[coords.length - 1] == 'W'
    value = "#{deg}.#{(minutes.to_f / 60).to_s.slice(2..10)}"
    south ? value.to_f * -1.0 : value.to_f
  end

  def coordinates_for(dms_coords)
    return default_coordinates if dms_coords.nil?
    coords_array = dms_coords.split(' ')
    {
      coordinates: "#{lat(coords_array.first)}, #{long(coords_array.last)}",
      latitude: lat(coords_array.first),
      longitude: long(coords_array.last)
    }
  end

  def persist_to_db(countries, hubs)
    Country.import(countries)
    Hub.import(hubs)
  end

  def default_coordinates
    {}.tap do |hash|
      hash[:coordinates] = nil
      hash[:longitude] = nil
      hash[:latitude] = nil
    end
  end

  BREAK_POINT = 900
  FINISHED_PROCESSING_MESSAGE = "We're done with above #{BREAK_POINT} records, they should keep updating over time :)".freeze
  UPDATE_CHANNEL = 'updates-channel'.freeze

  def send_client_updates
    if Hub.count.between?(900, 1000)
      Pusher.trigger(UPDATE_CHANNEL, 'sync-updates',
                     message: FINISHED_PROCESSING_MESSAGE)
    end
  end
end
