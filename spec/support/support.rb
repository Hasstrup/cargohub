module TestSupport
  module FileHelpers
    def yield_csv_slice
      csv_array = CSV.parse(file_fixture('mock.csv').read, headers: true).to_a
      @csv_slice = csv_array.each_slice(50).first
    end

    def mock_csv_row
      [
        nil,
        'LA',
        'CA',
        'Los California',
        '',
        '--3',
        'RL',
        nil,
        nil,
        nil,
        '4230N 00131E'
      ]
    end
  end
end
