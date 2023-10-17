require 'roo'

xlsx = Roo::Excelx.new(ARGV[0]) # Excelファイルを指定
variables = xlsx.row(1)
(2..xlsx.last_row).each do |row_number|
    values = xlsx.row(row_number)
    data = {}
    variables.each_with_index do |variable, index|
        data[variable] = values[index] # Excelの1行目とn行目を対応付ける
    end

    File.delete("/etc/openhab/items/#{data['itemID']}.items")
end