require 'pp'

@x = 0
@y = 0

@spiral_hash = { 1 => [@x, @y] }
                # 2 => [1, 0],
                # 3 => [1, 1],
                # 4 => [0, 1],
                # 5 => [-1, 1],
                # 6 => [0, 1],
                # 7 => [-1, -1],
                # 8 => [0, -1] }
                # 9 => [1, -1],
                # 10 => [2, -1],
                # 11 => [2, -1],
                # 12 => [0, 2],
                # 13 => [1, 2],
                # 14 => [2, 2],
                # 15 => [2, 3] }

# def populate_@spiral_hash
#
# end
#
# populate_@spiral_hash

@n = 1

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

def rotate
  right
  up
  left
  down
  right
  up
  left
  down
  right
  up
  left
  down
  right
  up
  left
  down
end

rotate
pp @spiral_hash
