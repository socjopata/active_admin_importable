require 'csv'
class CsvDb
  class << self
    def convert_save(target_model, csv_data, options, &block)
      csv_file = csv_data.read
      _options = options.merge({:headers => true, :header_converters => :symbol})
      CSV.parse(csv_file, _options) do |row|
        data = row.to_hash
        if data.present?
          if (block_given?)
             block.call(target_model, data)
           else
             target_model.create!(data)
           end
         end
      end
    end
  end
end