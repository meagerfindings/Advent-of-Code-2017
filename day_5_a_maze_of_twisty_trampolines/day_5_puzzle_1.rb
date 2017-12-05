require 'pp'
require 'CSV'

@input_array = []

def input_test_data_to_array
  counter = 0
  CSV.foreach('day_5_puzzle_1_test_input.csv') do |row_values|
    @input_array[counter] = row_values[0].to_i
    counter += 1
  end
end

def input_data_to_array
  counter = 0
  CSV.foreach('day_5_puzzle_1_input.csv') do |row_values|
    @input_array[counter] = row_values[0].to_i
    counter += 1
  end
end

def trampoline_jump

end

input_test_data_to_array
# input_data_to_array
trampoline_jump
pp @input_array
