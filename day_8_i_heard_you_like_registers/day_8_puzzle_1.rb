require 'CSV'

def import_test_data(target)
  input_hash = {}
  n = 0
  CSV.foreach(target) do |row|
    line = row[0].gsub(/\s+/, ' ').strip.split(' ')

    input_hash[n += 1] = { instruction_number: n,
                           register_name: line[0],
                           direction: line[1],
                           steps: line[2],
                           register_to_check: line[4],
                           equality: line[5],
                           register_check_value: line[6] }
  end
  input_hash
end

def create_registers(source)
  result = {}
  source.each do |_key, value|
    result[value[:register_name]] = 0
  end
  result
end

def instruction(target, direction, steps, register_to_check, equality, register_check_value)
  if @register_hash[register_to_check].public_send(equality, register_check_value)
    if direction == 'dec'
      @register_hash[target] -= steps
    else
      @register_hash[target] += steps
    end
  end
end

def run_instructions(source)
  source.each do |_key, value|
    instruction(value[:register_name].to_s,
                value[:direction].to_s,
                value[:steps].to_i,
                value[:register_to_check].to_s,
                value[:equality].to_s,
                value[:register_check_value].to_i)
  end
end

def find_largest_value
  largest = 0
  @register_hash.each do |_key, value|
    largest = value if value > largest
  end
  largest
end

# instruction_hash = import_test_data('day_8_puzzle_1_test_input.csv')
instruction_hash = import_test_data('day_8_puzzle_1_input.csv')
@register_hash = create_registers(instruction_hash)
run_instructions(instruction_hash)
puts "Largest value in a register: #{find_largest_value}"
