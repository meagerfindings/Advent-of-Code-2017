require 'pp'

input = ARGV[0].to_i

@target_number = input
@target_reached = false
@one_beyond = 0

@x = 0
@y = 0
@n = 1
@rotation_number = 1

@spiral_hash = { @x.to_s + @y.to_s => @n }

def right
  @n = check_blocks_around((@x += 1).to_s + @y.to_s)
  @spiral_hash[@x.to_s + @y.to_s] = @n
  destination_check
end

def up
  @n = check_blocks_around(@x.to_s + (@y += 1).to_s)
  @spiral_hash[@x.to_s + @y.to_s] = @n
  destination_check
end

def left
  @n = check_blocks_around((@x -= 1).to_s + @y.to_s)
  @spiral_hash[@x.to_s + @y.to_s] = @n
  destination_check
end

def down
  @n = check_blocks_around(@x.to_s + (@y -= 1).to_s)
  @spiral_hash[@x.to_s + @y.to_s] = @n
  destination_check
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

def check_blocks_around(location)
  val = 0
  unless @spiral_hash[(@x - 1).to_s + (@y - 1).to_s].nil?
    val += @spiral_hash[(@x - 1).to_s + (@y - 1).to_s]
  end
  unless @spiral_hash[(@x - 1).to_s + (@y + 0).to_s].nil?
    val += @spiral_hash[(@x - 1).to_s + (@y + 0).to_s]
  end
  unless @spiral_hash[(@x - 1).to_s + (@y + 1).to_s].nil?
    val += @spiral_hash[(@x - 1).to_s + (@y + 1).to_s]
  end
  unless @spiral_hash[(@x + 0).to_s + (@y - 1).to_s].nil?
    val += @spiral_hash[(@x + 0).to_s + (@y - 1).to_s]
  end
  unless @spiral_hash[(@x + 0).to_s + (@y + 1).to_s].nil?
    val += @spiral_hash[(@x + 0).to_s + (@y + 1).to_s]
  end
  unless @spiral_hash[(@x + 1).to_s + (@y - 1).to_s].nil?
    val += @spiral_hash[(@x + 1).to_s + (@y - 1).to_s]
  end
  unless @spiral_hash[(@x + 1).to_s + (@y + 0).to_s].nil?
    val += @spiral_hash[(@x + 1).to_s + (@y + 0).to_s]
  end
  unless @spiral_hash[(@x + 1).to_s + (@y + 1).to_s].nil?
    val += @spiral_hash[(@x + 1).to_s + (@y + 1).to_s]
  end
  val
end

def destination_check
  if @target_reached == false && @target_number < @n
    @one_beyond = @n
    @target_reached = true
  end
end

create_spiral(input)
pp @spiral_hash
pp @one_beyond
