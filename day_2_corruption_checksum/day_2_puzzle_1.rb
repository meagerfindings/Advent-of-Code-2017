require 'pp'
require 'CSV'

row = 0
input_hash = {}

CSV.foreach("day2puzzle1input.csv") do |row_values|
  temp_string = row_values[0].to_s
  temp_string.gsub!(/\t/, ',')

  input_hash[row] = []
  entry_string = ''
  temp_string.each_byte do |char|
    if char.chr == ','
      input_hash[row].push(entry_string.to_i)
      entry_string = ''
    else
      entry_string += char.chr
    end
  end
  input_hash[row].push(entry_string.to_i)
  row += 1
end

checksum = 0


input_hash.each do |_key, row_values|
  # puts row_values
  lowest_val = 1_000_000_000
  highest_val = 1
  row_values.each do |entry|
    pp entry
    lowest_val = entry if entry < lowest_val
    highest_val = entry if entry > highest_val
  end
  checksum += highest_val - lowest_val
  pp "Highest val #{highest_val}"
  pp "lowest val #{lowest_val}"
  pp "inprog check diff #{highest_val - lowest_val}"
  pp "Inprog checksum #{checksum}"
end

# pp input_hash
puts checksum
