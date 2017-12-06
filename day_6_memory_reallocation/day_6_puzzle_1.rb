require 'pp'

test_array = [0, 2, 7, 0]
input_array = [0,	5, 10, 0, 11, 14, 13, 4, 11, 8, 8, 7, 1, 4, 12, 11]
@cycle_history = []
@cycles = 0
@match = false

def find_largest(target)
  sorted_array = target.sort
  sorted_array[-1, 1][0]
end

def convert_blocks_to_string(target)
  converted_string = ''
  target.each do |x|
    converted_string += x.to_s
  end
  converted_string
end

def reallocate_cycle(target)
  largest = find_largest(target)
  index = target.index(largest)
  target[index] = 0
  until largest.zero?
    largest -= 1
    index += 1
    index = 0 if index >= target.length
    target[index] += 1
  end
  pp "Cycle blocks: #{target}"
  cycle_record = convert_blocks_to_string(target)
  if @cycle_history.include? cycle_record
    @match = true
  else
    @cycle_history.push(cycle_record)
  end
  pp "Cycle: #{@cycles += 1}"
end

def reallocate_all_the_things(target)
  reallocate_cycle(target) until @match == true
  @cycles
end

# pp "Total Cycles: #{reallocate_all_the_things(test_array)}"
pp "Total Cycles: #{reallocate_all_the_things(input_array)}"
