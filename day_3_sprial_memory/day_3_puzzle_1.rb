require 'pp'

@x = 0
@y = 0
@n = 1
rotation_number = 1

@spiral_hash = { @n => [@x, @y] }

def right
  @x += 1
  @n += 1
  @spiral_hash[@n] = [@x, @y]
end

def up
  @y += 1
  @n += 1
  @spiral_hash[@n] = [@x, @y]
end

def left
  @x -= 1
  @n += 1
  @spiral_hash[@n] = [@x, @y]
end

def down
  @y -= 1
  @n += 1
  @spiral_hash[@n] = [@x, @y]
end

# TODO: the pattern is that each rotation adds 2 for each direction. Need to figure out how to make that an alg

def rotate
  right # right 1
  up # up 1
  left
  left # left 2
  down
  down # down 2
end

def first_rotation
  right # right 1
  up # up 1
  left
  left # left 2
  down
  down # down 2
end

def second_rotation
  right
  right
  right # right 3
  up
  up
  up # up 3
  left
  left
  left
  left # left 4
  down
  down
  down
  down # down 4
end

def third_rotation
  right
  right
  right
  right
  right # right 5
  up
  up
  up
  up
  up # up 5
  left
  left
  left
  left
  left
  left # left 6
  down
  down
  down
  down
  down
  down # down 6
end

def fourth_rotation
  right
  right
  right
  right
  right
  right
  right # right 7
  up
  up
  up
  up
  up
  up
  up # up 7
  left
  left
  left
  left
  left
  left
  left
  left # left 8
  down
  down
  down
  down
  down
  down
  down
  down # down 8
end

first_rotation
second_rotation
third_rotation
fourth_rotation
pp @spiral_hash
