require 'set'
def walk(data, direction)
  #Entrywise sum
  data[:position] = data[:position].zip(direction).map { |e| e.reduce(:+)  }
  data[:visited].add(data[:position])
  data
end
File.open('03_1.input', 'r') do |file|
  file.gets
    .split('')
    .map do |e| case e
    when '^'
      [1, 0]
    when '<'
      [0, -1]
    when 'v'
      [-1, 0]
    when '>'
      [0, 1]
    else
      [0, 0]
    end
  end
  .reduce({ position: [0, 0], visited: Set.new }) { |data, direction| walk(data, direction)  } [:visited]
  .size()
end
