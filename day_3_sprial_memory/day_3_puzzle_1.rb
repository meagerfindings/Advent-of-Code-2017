require 'pp'

input = ARGV[0].to_i

@x = 0
@y = 0
@n = 1
@rotation_number = 1

@spiral_hash = { @n => [@x, @y] }

def right
  @spiral_hash[@n += 1] = [@x += 1, @y]
end

def up
  @spiral_hash[@n += 1] = [@x, @y += 1]
end

def left
  @spiral_hash[@n += 1] = [@x -= 1, @y]
end

def down
  @spiral_hash[@n += 1] = [@x, @y -= 1]
end

def rotate
  right_up_num = 2 * @rotation_number - 1
  right_up_num.times { right }
  right_up_num.times { up }

  left_down_num = 2 * @rotation_number
  left_down_num.times { left }
  left_down_num.times { down }

  @rotation_number += 1
end

def create_spiral(input)
  rotate until @n >= input
end

def calculate_steps(input)
  steps = 0
  @spiral_hash[input].each do |x|
    steps += x.abs
  end
  steps
end

create_spiral(input)
# pp @spiral_hash
pp "Steps taken: #{calculate_steps(input)}"
