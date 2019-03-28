require 'zip'

# gets the zip from UNECE and processes
class UneceRetrieveInteractor
  include Interactor
  UNECE_URI = 'https://www.unece.org/fileadmin/DAM/cefact/locode/loc182csv.zip'.freeze

  def call
    content = HTTParty.get(UNECE_URI).body
    Zip::File.open_buffer(content).each do |zip|
      binding.pry
      zip.each do |zip_file|
        puts zip_file.name
      end
    end
  end

  private

  def parse_csv_data; end
 end
