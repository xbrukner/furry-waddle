require 'set'
class Delivery
  def initialize(count)
    @count = count
    @positions = []
    @visited = []
    @count.times {
        @positions.push [0, 0]
        @visited.push Set.new
    }
    @turn = 0
  end

  def position=(pos)
    @positions[@turn] = pos
  end

  def position
    @positions[@turn]
  end

  def visit(pos)
    @visited[@turn].add(pos)
  end

  def nextTurn
    @turn = (@turn + 1) % @count
  end

  def walk(direction)
    self.position = self.position.zip(direction).map { |e| e.reduce(:+)  }
    visit(self.position)
    nextTurn
    self
  end

  def size
    @visited.reduce(&:|).size()
  end
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
  .reduce(Delivery.new(2), &:walk)
  .size()
end
