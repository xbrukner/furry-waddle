require 'set'
class Frame
  @@maxcolumn = 1000
  def initialize(*args)
    if args.length == 1 then
      init_str(*args)
    else
      init_pos(*args)
    end
  end

  def init_str(str)
    @str = str
    @row, @column = str.split(',').map { |e| e.to_i }
    @num = @row * @@maxcolumn + @column
  end

  def init_pos(row, column)
    @str = "#{row},#{column}"
    @row = row
    @column = column
    @num = row * @@maxcolumn + column
  end

  attr_reader :row, :column, :num, :str
end

def rectangle(from, to)
  (from.row..to.row).each do |row|
    (from.column..to.column).each do |column|
      yield Frame.new(row, column)
    end
  end
end

class Grid
  def initialize()
    @on = Set.new
  end

  def block(from, to)
    rectangle(from, to) do |e|
      @on = yield(@on, e.num)
    end
  end

  def turnOn(from, to)
    block(from, to) { |set, e| set.add(e) }
  end

  def turnOff(from, to)
    block(from, to) { |set, e| set.delete(e) }
  end

  def toggle(from, to)
    block(from, to) do |set, e|
      if set.include?(e) then
        set.delete(e)
      else
        set.add(e)
      end
    end
  end

  def length()
    @on.length
  end
end

File.open('06_1.input', 'r') do |file|
  g = Grid.new
  file.readlines
    .each do |str|
      /turn on ([0-9]*,[0-9]*) through ([0-9]*,[0-9]*)/.match(str) { |m| g.turnOn(Frame.new(m[1]), Frame.new(m[2])) }
      /turn off ([0-9]*,[0-9]*) through ([0-9]*,[0-9]*)/.match(str) { |m| g.turnOff(Frame.new(m[1]), Frame.new(m[2])) }
      /toggle ([0-9]*,[0-9]*) through ([0-9]*,[0-9]*)/.match(str) { |m| g.toggle(Frame.new(m[1]), Frame.new(m[2])) }
    end
  g.length
end
