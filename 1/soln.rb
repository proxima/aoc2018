require "set"

def part_one
  file = File.open 'input.txt', 'r'
  file.each_line.map { |x| x.to_i }.reduce(:+)
end

def part_two
  file = File.open 'input.txt', 'r'
  memo = [ Set.new, 0 ]

  loop do
    file.each_line.map { |x| x.to_i }.inject(memo) do |memo, x|
      memo[1] += x
      return memo[1] if memo[0].include? memo[1]
      memo[0].add memo[1]
      memo
    end
    file.seek 0, IO::SEEK_SET
  end
end

p part_one
p part_two
