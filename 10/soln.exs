defmodule AdventDay10 do
  def parse() do
    parsing_regex = ~r{position=<\s?(-?\d+),\s+(-?\d+)>\s+velocity=<\s?(-?\d+),\s+(-?\d+)>}

    splits =
      File.read!("input.txt")
      |> String.split("\n", trim: true)
      |> Enum.map(fn x -> Regex.run(parsing_regex, x, capture: :all_but_first) end)
      |> Enum.map(fn list ->
        Enum.map(list, &String.to_integer/1)
        |> Enum.to_list()
      end)

    splits
  end

  def advance([x, y, dx, dy]) do
    [x + dx, y + dy, dx, dy]
  end

  def printable(list) do
    {
      [_, min_y, _, _],
      [_, max_y, _, _]
    } = Enum.min_max_by(list, &Enum.at(&1, 1))

    if max_y - min_y < 19 do
      true
    else
      false
    end
  end

  def iterate(list, iterations) do
    if(printable(list)) do
      {list, iterations}
    else
      list
      |> Enum.map(fn x -> advance(x) end)
      |> iterate(iterations + 1)
    end
  end

  def init() do
    pv = parse()

    {condensed, iterations} = iterate(pv, 0)

    points =
      for x <- condensed do
        Enum.take(x, 2)
      end

    set = MapSet.new()

    set =
      Enum.reduce(points, set, fn x, acc ->
        MapSet.put(acc, x)
      end)

    {[min_x, _], [max_x, _]} = Enum.min_max_by(set, &Enum.at(&1, 0))
    {[_, min_y], [_, max_y]} = Enum.min_max_by(set, &Enum.at(&1, 1))

    IO.puts("#{iterations}")

    for col <- min_y..max_y do
      for row <- min_x..max_x do
        if MapSet.member?(set, [row, col]) do
          IO.write("#")
        else
          IO.write(" ")
        end
      end

      IO.write("\n")
    end
  end
end

AdventDay10.init()
