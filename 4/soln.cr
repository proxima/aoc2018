require "time"

# Make Time compatible with Range
struct Time
  def succ
    self + Time::Span.new(0, 1, 0)
  end
end

def process_records
  file = File.open "input.txt", "r"

  records = [] of Tuple(Time,String)

  file.each_line do |l|
    t = Time.parse_local l[1..16], "%F %R"
    rest = l[19..-1]
    records << { t, rest }
  end

  records.sort! { |x,y| x.first <=> y.first }

  on_duty = 0

  sleep_log = {} of Int32 => Array(Range(Time,Time))
  t = Time.new

  records.each do |r|
    case r.last
    when /Guard #(\d+) begins shift/
      on_duty = $1.to_i
    when /falls asleep/
      t = r.first
    when /wakes up/
      sleep_log[on_duty] ||= Array(Range(Time,Time)).new
      sleep_log[on_duty] << Range(Time,Time).new t, r.first, true
    end
  end

  records_by_minute = {} of Int32 => Array(Int32)

  sleep_log.each do |k,v|
    records_by_minute[k] ||= Array(Int32).new

    v.each do |r|
      r.each do |t|
        records_by_minute[k] << t.minute
      end
    end
  end

  records_by_minute
end

def part_one
  records_by_minute = process_records
  sorted = records_by_minute.to_a.sort_by { |k,v| -v.size }.first
  minute = sorted.last.group_by { |x| x }.to_a.sort_by { |k,v| -v.size }.first.first
  guard_id = sorted.first
  guard_id * minute
end

def part_two
  records_by_minute = process_records

  records = Array(Tuple(Int32,Int32,Int32)).new

  records_by_minute.each do |k,v|
    minute = v.group_by { |x| x }.to_a.sort_by { |k,v| -v.size }.first
    records << { k, minute.first, minute.last.size }
  end

  sorted = records.sort_by { |x| -x.last }.first
  sorted[0] * sorted[1]
end

p part_one
p part_two
