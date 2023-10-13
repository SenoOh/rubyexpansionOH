require 'roo'
require 'erb'

xlsx = Roo::Excelx.new(ARGV[0]) # Excelファイルを指定
row_count = xlsx.last_row # Excelの行数を確認
variables = xlsx.row(1)
values = xlsx.row(2)
data = {} # Excelの1行目と2行目を対応付ける
variables.each_with_index do |variable, index|
  data[variable] = values[index]
end

erb_template = ERB.new(File.read(ARGV[1]), trim_mode: '-') # erbファイルを開く
output = erb_template.result(binding) # erbファイルを書き換える
File.open("#{__dir__}/template/created_thing.erb", 'w') { |file| file.write(output) } # 新しいファイルにoutputでの変更を書き換える

if row_count >= 3
  (3..xlsx.last_row).each do |row_number|
    new_values = xlsx.row(row_number)
    new_data = {}
    variables.each_with_index do |variable, index|
      new_data[variable] = new_values[index]
    end
    new_erb_template = ERB.new(File.read(ARGV[2]), trim_mode: '-')
    new_output = new_erb_template.result(binding)
    File.open("#{__dir__}/template/created_channel.erb", 'w') { |file| file.write(new_output) }
    channel_erb = File.read("#{__dir__}/template/created_channel.erb")
    parent_erb = File.read("#{__dir__}/template/created_thing.erb")
    updated_content = parent_erb.gsub("here", channel_erb) # parent_erb内の"here"をchannel_erbに書き換える
    File.open("#{__dir__}/template/created_thing.erb", 'w') do |file|
      file.puts updated_content # created_thing.erbにupdated_contentでの変更を書き換える
    end
  end
end

parent_erb = File.read("#{__dir__}/template/created_thing.erb")
remove_here = parent_erb.gsub("here", "") # parent_erb内の"here"を取り除く
File.open("#{__dir__}/template/created_thing.erb", 'w') do |file|
  file.puts remove_here # created_thing.erbにremove_hereでの変更を書き換える
end
File.open("#{__dir__}/template/created_thing.erb", "r") do |input_file|
  File.open("#{__dir__}/template/fixed_thing.erb", "w") do |output_file|
    input_file.each_line do |line|
      output_file.write(line) unless line.strip.empty? # 空行以外を書き込み
    end
  end
end
FileUtils.cp("#{__dir__}/template/fixed_thing.erb", "/etc/openhab/things/#{data['thingID']}.things")