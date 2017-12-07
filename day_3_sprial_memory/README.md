# Day 3

## --- Day 3: Spiral Memory ---

You come across an experimental new kind of memory stored on an infinite two-dimensional grid.

Each square on the grid is allocated in a spiral pattern starting at a location marked 1 and then counting up while spiraling outward. For example, the first few squares are allocated like this:

```
17  16  15  14  13
18   5   4   3  12
19   6   1   2  11
20   7   8   9  10
21  22  23---> ...
```

While this is very space-efficient (no squares are skipped), requested data must be carried back to square 1 (the location of the only access port for this memory system) by programs that can only move up, down, left, or right. They always take the shortest path: the Manhattan Distance between the location of the data and square 1.

```
For example:

    Data from square 1 is carried 0 steps, since it's at the access port.
    Data from square 12 is carried 3 steps, such as: down, left, left.
    Data from square 23 is carried only 2 steps: up twice.
    Data from square 1024 must be carried 31 steps.
```

### Task
**How many steps are required to carry the data from the square identified in your puzzle input all the way to the access port?**

Steps taken: `419`

_Your puzzle input is `289326`._

#### My Solution

```
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
  if @rotation_number == 1
    right
    up
  else
    right_up_num = 2 * @rotation_number - 1
    right_up_num.times { right }
    right_up_num.times { up }
  end
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
```
---

## --- Part Two ---

As a stress test on the system, the programs here clear the grid and then store the value `1` in square `1`. Then, in the same allocation order as shown above, they store the sum of the values in all adjacent squares, including diagonals.

So, the first few squares' values are chosen as follows:

    Square `1` starts with the value `1`.
    Square `2` has only one adjacent filled square (with value 1), so it also stores `1`.
    Square `3` has both of the above squares as neighbors and stores the sum of their values, `2`.
    Square `4` has all three of the aforementioned squares as neighbors and stores the sum of their values, `4`.
    Square `5` only has the first and fourth squares as neighbors, so it gets the value `5`.

Once a square is written, its value does not change. Therefore, the first few squares would receive the following values:

```
147  142  133  122   59
304    5    4    2   57
330   10    1    1   54
351   11   23   25   26
362  747  806--->   ...
```

### Task
What is the **first value written** that is **larger** than your puzzle input?

Next value is: `295229`

_Your puzzle input is still_ `289326`.

#### My Solution

```
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
```
