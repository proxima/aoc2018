def part_one
  file = File.open "input.txt", "r"

  num_two = num_three = 0

  file.each_line do |l|
    l += '\n'

    l.each_char.reduce({} of Char => Int32) do |memo, ch|
      next if memo.nil?

      if ch == '\n'
        num_two += 1 if memo.values.includes? 2
        num_three += 1 if memo.values.includes? 3
        next
      end

      memo[ch] ||= 0
      memo[ch] += 1
      memo
    end
  end

  num_two * num_three
end

def part_two
  file = File.open "input.txt", "r"
  
  file.each_line.to_a.permutations(2).each do |perm|
    next if perm[0].size != perm[1].size

    prefix = 0
    until perm[0][prefix] != perm[1][prefix]
      prefix += 1
    end

    perm[0] = perm[0].reverse
    perm[1] = perm[1].reverse

    suffix = 0
    until perm[0][suffix] != perm[1][suffix]
      suffix += 1
    end

    perm[0] = perm[0].reverse
    perm[1] = perm[1].reverse

    if prefix + suffix == perm[0].size - 1
      return "#{perm[0][0, prefix]}#{perm[0][prefix + 1, suffix]}"
    end
  end
end

p part_one
p part_two
