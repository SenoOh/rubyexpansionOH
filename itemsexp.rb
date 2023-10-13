require 'roo'
require 'erb'

xlsx = Roo::Excelx.new(ARGV[0]) # Excelファイルを指定
variables = xlsx.row(1)
(2..xlsx.last_row).each do |row_number|
    values = xlsx.row(row_number)
    data = {}
    variables.each_with_index do |variable, index|
        data[variable] = values[index] # Excelの1行目とn行目を対応付ける
    end
    erb_template = ERB.new(File.read(ARGV[1])) # erbファイルを開く

    output = erb_template.result(binding) # erbファイルを書き換える
    File.open("/etc/openhab/items/#{data['itemID']}.items", 'w') { |file| file.write(output) } # 新しいファイルにoutputでの変更を書き換える
end