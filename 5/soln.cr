require "deque"

def part_one
  chars = Array(Char).new
  reacted = Array(Char).new
  reacted << ' '

  File.open "input.txt", "r" do |file|
    chars = file.gets_to_end.each_char.to_a
  end

  chars.each do |x|
    if reacted[-1].downcase == x.downcase && reacted[-1] != x
      reacted.pop
    else
      reacted << x
    end
  end

  puts "#{reacted.join.strip.size}"
  reacted.join.strip
end

def part_two
  result = part_one

  reacted = [ ' ' ]
  
  result.downcase.each_char.to_a.uniq.map do |x|
    reacted = [ ' ' ]
    result.each_char.to_a.reject do |y|
      y.downcase == x
    end.each do |x|
      if reacted[-1].downcase == x.downcase && reacted[-1] != x
        reacted.pop
      else
        reacted << x
      end
    end
    reacted.join.strip.size
  end.min
end

p part_two
