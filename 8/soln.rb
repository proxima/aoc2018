class Node
  attr_reader :num_children, :num_metadata
  attr_reader :children, :metadata

  def initialize(list)
    @num_children = list.shift
    @num_metadata = list.shift

    @children = []
    @metadata = []

    @num_children.downto(1).each do |i|
      @children << Node.new(list)
    end

    @num_metadata.downto(1).each do |i|
      @metadata << list.shift
    end
  end
end

def sum_visit(node)
  sum = node.metadata.sum

  node.children.each do |c|
    sum += sum_visit(c)
  end

  sum
end

def part_one
  input = []

  File.open "input.txt", "r" do |file|
    input = file.gets.chomp.split(/ /).map { |x| x.to_i }
  end

  node = Node.new input

  sum_visit(node)
end

def special_visit(node)
  value = 0

  if node.num_children > 0
    node.metadata.each do |meta|
      next if meta == 0
      meta = meta - 1

      if meta >= 0 && meta < node.children.size
        value += special_visit(node.children[meta])
      end
    end
  else
    value += node.metadata.sum 
  end

  value
end

def part_two
  input = []

  File.open "input.txt", "r" do |file|
    input = file.gets.chomp.split(/ /).map { |x| x.to_i }
  end

  node = Node.new input

  special_visit(node)
end

p part_one
p part_two
