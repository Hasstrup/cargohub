require 'zip'

# gets the zip from UNECE and processes
class UneceRetrieveInteractor
  include Interactor
  UNECE_URI = 'https://www.unece.org/fileadmin/DAM/cefact/locode/loc182csv.zip'.freeze
  BATCH_SIZE = 600

  def call
    content = HTTParty.get(UNECE_URI).body
    Zip::File.open_buffer(content).each do |zip|
      parse_csv_data(zip.get_input_stream.read) if zip.name.include?('CodeListPart')
    end
  end

  private

  def parse_csv_data(stream)
    csv_array = CSV.parse(stream, headers: true).to_a.shift
    csv_array.each_slice(BATCH_SIZE) do |batch|
      HubsProcessJob.perform_later(batch)
    end
  end
end
