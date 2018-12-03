require "set"

def solution
  file = File.open "input.txt", "r"
  
  locations = {} of Tuple(Int32,Int32) => Array(Int32)
  overlaps  = {} of Int32 => Set(Int32)
  
  file.each_line do |l|
    match = l.match /#(\d+) @ (\d+),(\d+): (\d+)x(\d+)/

    match.try do |m|
      claim, x, y, w, h = m[1].to_i, m[2].to_i, m[3].to_i, m[4].to_i, m[5].to_i

      overlaps[claim] = Set(Int32).new

      (x...x+w).each do |row|
        (y...y+h).each do |col|
          if !locations.has_key?({row, col})
            locations[{row, col}] = [] of Int32
          else
            locations[{row, col}].each do |c|
              overlaps[claim].add c
              overlaps[c].add claim
            end
          end

          locations[{row, col}] << claim
        end
      end
    end
  end

  p locations.values.select { |x| x.size > 1 }.size
  overlaps.find { |k, v| v.size == 0 }.try do |overlap|
    p overlap.first
  end
end

solution
