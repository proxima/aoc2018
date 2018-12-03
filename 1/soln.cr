require "set"

def part_one
  file = File.open "input.txt", "r"
  file.each_line.map { |x| x.to_i }.sum
end

def part_two
  file = File.open "input.txt", "r"

  sum = 0
  seen = Set(Int32).new

  file.each_line.to_a.map { |x| x.to_i }.cycle do |delta|
    sum += delta
    break sum if seen.includes? sum
    seen.add sum
  end

  sum
end

p part_one
p part_two
