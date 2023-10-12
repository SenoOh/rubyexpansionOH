require 'roo'
require 'erb'

xlsx = Roo::Excelx.new(ARGV[0]) 
xlsx.default_sheet = xlsx.sheets.first
variables = xlsx.row(1)
(2..xlsx.last_row).each do |row_number|
    values = xlsx.row(row_number)
    data = {}
    variables.each_with_index do |variable, index|
        data[variable] = values[index]
    end
    erb_template = ERB.new(File.read(ARGV[1]))

    output = erb_template.result(binding) 
    File.open("/etc/openhab/items/#{data['itemID']}.items", 'w') { |file| file.write(output) }
end