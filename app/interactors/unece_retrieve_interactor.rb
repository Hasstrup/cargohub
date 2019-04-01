require 'zip'

# gets the zip from UNECE and processes
class UneceRetrieveInteractor
  include Interactor
  UNECE_URI = 'https://www.unece.org/fileadmin/DAM/cefact/locode/loc182csv.zip'.freeze
  BATCH_SIZE = 600

  before :clean_up_database

  def call
    content = HTTParty.get(UNECE_URI).body
    Zip::File.open_buffer(content).each do |zip|
      parse_csv_data(zip) if zip.name.include?('CodeListPart')
    end
  rescue StandardError => error
    context.fail!(errors: error)
  end

  private

  def parse_csv_data(zip)
    encoded_stream = zip
                     .get_input_stream
                     .read
                     .force_encoding('iso-8859-1')
                     .encode('utf-8')
    csv_array = CSV.parse(encoded_stream, headers: true).to_a
    csv_array.shift
    csv_array.slice(0,100).each_slice(BATCH_SIZE) do |batch|
      HubsProcessJob.perform_later(batch)
    end
  end

  def clean_up_database
    Hub.delete_all
    Country.delete_all
  end
end
