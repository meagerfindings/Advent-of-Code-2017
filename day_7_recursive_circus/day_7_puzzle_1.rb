require 'pp'
require 'CSV'

@input_hash = {}
@tower_hash = {}
@tower_top = []
@most_children = 0
@found_bottom = false

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
  pp @tower_top
  check_top_number
end

def check_top_number
  @found_bottom = true if @tower_top.length == 1
end

def build_tower
  # 5.times { build_tower_layers }
  build_tower_layers until @found_bottom == true
  @tower_top[0]
end

# import_test_data
import_data
build_tower_top
pp "Tower bottom: #{build_tower}"
