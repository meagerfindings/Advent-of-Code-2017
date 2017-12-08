require 'pp'
require 'CSV'

@input_hash = {}
@tower_hash = {}
@tower_top = []
@most_children = 0
@found_bottom = false
@layer = 0
@weight_hash = {}
@problem_layer = []

def import_test_data
  CSV.foreach('day_7_puzzle_1_test_input.csv') do |row_values|
    id = ''
    weight = ''
    child1 = ''

    id += row_values[0][0..7].gsub(/[^a-z]/, '')
    weight += row_values[0].gsub(/[^0-9]/, '')
    child1 = row_values[0][7..-1].gsub(/[^a-z]/, '')

    @input_hash[id] = { id: id, weight: weight, children: [] }

    @input_hash[id][:children].push(child1) unless child1.empty?

    row_values[1..-1].each do |x|
      @input_hash[id][:children].push(x.strip) unless x.nil?
      @most_children = @input_hash[id][:children].length unless @most_children > @input_hash[id][:children].length
    end
    @input_hash[id][:children_number] = @input_hash[id][:children].length
  end
end

def import_data
  CSV.foreach('day_7_puzzle_1_input.csv') do |row_values|
    id = ''
    weight = ''
    child1 = ''

    id += row_values[0][0..7].gsub(/[^a-z]/, '')
    weight += row_values[0].gsub(/[^0-9]/, '')
    child1 = row_values[0][7..-1].gsub(/[^a-z]/, '')

    @input_hash[id] = { id: id, weight: weight, children: [] }

    @input_hash[id][:children].push(child1) unless child1.empty?

    row_values[1..-1].each do |x|
      @input_hash[id][:children].push(x.strip) unless x.nil?
      @most_children = @input_hash[id][:children].length unless @most_children > @input_hash[id][:children].length
    end
    @input_hash[id][:children_number] = @input_hash[id][:children].length
  end
end

def build_tower_top
  @input_hash.each do |_outer, key|
    next unless key[:children_number] == 0
    @tower_top.push(key[:id])
  end
end

def build_tower_layers
  new_top = []
  @input_hash.each do |_outer, key|
    next unless key[:children_number] > 0
    key[:children].each do |child|
      next unless @tower_top.include? child
      @input_hash[child][:parent] = key[:id]
      new_top.push(key[:id])
    end
  end

  @tower_top = new_top.uniq

  @tower_hash[@layer.to_s] = []

  @tower_top.each do |x|
    @input_hash[x][:layer] = @layer
    # @tower_hash[@layer.to_s].push(@input_hash[x][:weight])
  end
  # pp @tower_hash
  @layer += 1

  check_top_number
end

def check_top_number
  @found_bottom = true if @tower_top.length == 1
end

def build_tower
  build_tower_layers until @found_bottom == true
end

def calculate_tower_weights
  @input_hash.each do |_key, x|
    next unless x[:children_number] > 0
    tower_weight = x[:weight].to_i
    x[:children].each do |y|
      tower_weight += @input_hash[y][:weight].to_i
    end
    x[:tower_weight] = tower_weight
  end
end

def print_layer_weights
  loops = 0
  while loops < @layer
    @weight_hash[loops] = []
    inner_loop_count = 0
    last_key = ''
    @input_hash.each do |_empty, key|
      next unless key[:layer] == loops
      if inner_loop_count > 0 && @layer > 0
        unless @weight_hash[loops].include? key[:tower_weight].to_i
          @weight_hash[loops].push(key[:tower_weight])
          pp @weight_hash[loops]
          if key[:tower_weight] > @weight_hash[loops][0]
            difference = key[:tower_weight] - @weight_hash[loops][0]
            pp key[:weight].to_i - difference.abs
          else
            difference = @weight_hash[loops][0] - key[:tower_weight]
            puts "!!!!!"
            pp @input_hash[last_key]
            pp @input_hash[last_key][:weight].to_i - difference
          end
        end
      end
      @weight_hash[loops].push(key[:tower_weight])
      inner_loop_count += 1
      last_key = key[:id]
    end
    loops += 1
  end
end


# import_test_data
import_data
build_tower_top
build_tower
calculate_tower_weights
pp print_layer_weights

# pp @weight_hash
# pp
# pp @input_hash
# pp @tower_hash
