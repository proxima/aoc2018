require "set"

def part_one
  file = File.open 'input.txt', 'r'
  file.each_line.map { |x| x.to_i }.reduce(:+)
end

def part_two
  file = File.open 'input.txt', 'r'

  s = Set.new
  sum = 0

  file.each_line.map { |x| x.to_i }.cycle do |delta|
    sum += delta
    return sum if s.include? sum
    s.add sum
  end
end

p part_one
p part_two
