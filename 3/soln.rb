require "set"

def solution
  file = File.open "input.txt", "r"
  
  locations = {}
  overlaps  = {}
  
  file.each_line do |l|
    m = match = l.match /#(\d+) @ (\d+),(\d+): (\d+)x(\d+)/

    claim, x, y, w, h = m[1].to_i, m[2].to_i, m[3].to_i, m[4].to_i, m[5].to_i

    overlaps[claim] = Set.new

    (x...x+w).each do |row|
      (y...y+h).each do |col|
        if !locations.include?([row, col])
          locations[[row, col]] = []
        else
          locations[[row, col]].each do |c|
            overlaps[claim].add c
            overlaps[c].add claim
          end
        end

        locations[[row, col]] << claim
      end
    end
  end

  [ locations.values.select { |x| x.size > 1 }.size, overlaps.find { |k, v| v.size == 0 }.first ]
end

p solution
