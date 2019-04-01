require 'zip'

module TestSupport
  module FileHelpers
    def yield_csv_slice
      csv_array = CSV.parse(file_fixture('mock.csv').read, headers: true).to_a
      @csv_slice = csv_array.each_slice(50).first
    end

    def stub_unece_request
      create_zip_payload
      stub_request(:get, UneceRetrieveInteractor::UNECE_URI)
        .to_return(status: 200, body: File.open(@response_file_path, 'rb').read)
    end

    def set_request_failure
      stub_request(:get, UneceRetrieveInteractor::UNECE_URI)
        .to_return(status: [500, 'Internal server error'])
    end

    def create_zip_payload
      folder = Rails.root.join('spec/fixtures/files/zip_content')
      input_filenames = ['MockCodeListPart1.csv', 'MockCodeListPart2.csv']
      @response_file_path = Rails.root.join('spec/fixtures/body.zip')
      Zip::File.open(@response_file_path, Zip::File::CREATE) do |zipfile|
        input_filenames.each do |filename|
          zipfile.add(filename, File.join(folder, filename))
        end
      end
   rescue Zip::EntryExistsError => error # fail quietly
     Rails.logger.error(error)
   end

    def mock_csv_row
      [nil, 'LA', 'CA',
       'Los California', '', '--3',
       'RL', nil, nil, nil, '4230N 00131E']
    end
  end
end
