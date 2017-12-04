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
  result = 0
  row_values.each do |entry|
    row_values.each do |inner_entry|
      next if entry == inner_entry
      temp_result = entry / inner_entry
      result = temp_result if temp_result.integer?
      if result == 0
        next if entry == inner_entry
        temp_result = inner_entry / entry
        result = temp_result if temp_result.integer?
      end
    end
  end

  checksum += result
end

# pp input_hash
puts checksum
