def manhattan_distance(p1, p2)
  (p1[0] - p2[0]).abs + (p1[1] - p2[1]).abs
end

def closest(points, x, y)
  p1, p2 = points.each.map { |p| [ manhattan_distance(p, [ x, y ]), p] }.sort_by { |distance, pt| distance }.take(2)
  p1[0] == p2[0] ? nil : p1[1]
end

def infinite?(distances, point, xmax, ymax)
  return false if point.nil?

  x, y = point[0], point[1]

  [ distances[0][y], distances[x][0], distances[0][ymax], distances[xmax][0] ].include? point
end

def sum_closest(points, x, y)
  points.inject(0) { |sum, point| sum + manhattan_distance(point, [x, y]) } < 10_000
end

def solve
  points = []

  File.open "input.txt", "r" do |file|
    file.each_line do |l|
      tmp = l.split(",")
      points << [ tmp.first.to_i, tmp.last.to_i ]
    end
  end

  max_x = points.map { |x| x[0] }.max
  max_y = points.map { |x| x[1] }.max

  distances = []

  (0..max_x).each do |x|
    distances[x] ||= []
    (0..max_y).each do |y|
      distances[x][y] = closest(points, x, y)
    end
  end

  results = distances.clone.flatten(1).group_by(&:itself)
    .transform_values(&:count)
    .delete_if { |point, _count| infinite?(distances, point, max_x, max_y) }

  puts "Part one: #{results.sort_by { |_, y| -y }.first[1]}"

  answers = []

  (0..max_x).each do |x|
    (0..max_y).each do |y|
      answers << [ x, y ] if sum_closest(points, x, y)
    end
  end

  puts "Part two: #{answers.count}"
end

solve
