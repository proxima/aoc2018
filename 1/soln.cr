require "set"

def part_one
  file = File.open "input.txt", "r"
  file.each_line.map { |x| x.to_i }.sum
end

def part_two
  file = File.open "input.txt", "r"

  memo = { Set(Int32).new, 0 }

  loop do
    memo = file.each_line.map { |x| x.to_i }.reduce(memo) do |memo, x|
      memo = { memo[0], memo[1] + x }
      return memo[1] if memo[0].includes? memo[1]
      memo[0].add memo[1]
      memo
    end
    file.seek 0, IO::Seek::Set
  end
end

p part_one
p part_two
