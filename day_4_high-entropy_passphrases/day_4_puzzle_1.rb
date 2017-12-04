require 'pp'
require 'CSV'

@input_hash = {}

def input_data_to_hash
  counter = 0
  CSV.foreach('day_4_puzzle_1_input.csv') do |row_values|
    temp_string = row_values[0].to_s
    @input_hash["password#{counter}"] = { password: temp_string,
                                          pass_array: [],
                                          high_entropy: false }
    counter += 1
  end
end

def create_arrays_from_passwords
  @input_hash.each_value do |pass|
    entry_string = ''
    pass[:password].each_byte do |char|
      if char.chr == ' '
        pass[:pass_array].push(entry_string)
        entry_string = ''
      else
        entry_string += char.chr
      end
    end
    pass[:pass_array].push(entry_string)
  end
end

def evaluate_passwords
  valid_passwords = 0
  @input_hash.each_value do |pass|
    if pass[:pass_array].uniq.length == pass[:pass_array].length
      pass[:high_entropy] = true
      valid_passwords += 1
    end
  end
  valid_passwords
end

input_data_to_hash
create_arrays_from_passwords
pp "Valid Passwords: #{evaluate_passwords}"
