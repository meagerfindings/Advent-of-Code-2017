require 'CSV'

@input_array = []
@steps = 0
@jump_destination = 0

def input_data_to_array(source)
  CSV.foreach(source) do |row_values|
    @input_array.push(row_values[0].to_i)
  end
end

def trampoline_jump
  attention = @input_array[@jump_destination]
  result = 'jumping'
  index = @jump_destination
  if attention.nil?
    result = "Steps taken: #{@steps}"
  else
    @jump_destination = attention + index
    if @jump_destination - index >= 3 || @jump_destination + index <= -3
      @input_array[index] -= 1
    else
      @input_array[index] += 1
    end
    @steps += 1
  end
  result
end

def start_jumping
  trampoline_jump until trampoline_jump != 'jumping'
  trampoline_jump
end

# input_data_to_array('day_5_puzzle_1_test_input.csv')
input_data_to_array('day_5_puzzle_1_input.csv')
puts start_jumping
