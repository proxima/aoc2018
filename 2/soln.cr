def part_one
  file = File.open "input.txt", "r"

  num_two = num_three = 0

  file.each_line do |l|
    groups = l.each_char.group_by { |c| c }

    num_two   += 1 if groups.any? { |k,v| v.size == 2 }
    num_three += 1 if groups.any? { |k,v| v.size == 3 }
  end

  num_two * num_three
end

def part_two
  file = File.open "input.txt", "r"

  file.each_line.to_a.permutations(2).each do |perm|
    zipped = perm.first.chars.zip(perm.last.chars)

    common = zipped.select { |a, b| a == b }
    
    if common.size == perm.first.size - 1
      zipped.each_with_index do |combined, index|
        if combined.first != combined.last
          return "#{perm.first[0, index]}#{perm.first[index + 1, perm.first.size - index]}"
        end
      end
    end
  end
end

p part_one
p part_two
