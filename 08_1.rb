class EscapeCount
  def initialize
    @total = 0
    @unescaped = 0
  end

  def handle(line)
    line.chomp!
    i = 1
    lastBackslash = false
    skip = 0
    until i == line.length-1 do
      j = line[i]
      if lastBackslash then
        if j == '\\' or j == '"' then
          skip += 1 #Just backslash
        elsif j == 'x' then
          skip += 3 #\xAA -> single character
          i += 2
        end
        lastBackslash = false
      elsif line[i] == '\\' then
        lastBackslash = true
      end
      i += 1
    end
    @total += line.length
    @unescaped += line.length - skip - 2 #2 = starting " and ending "
  end

  def extra()
    @total - @unescaped
  end
end

File.open("08_1.input", "r") do |file|
  ec = EscapeCount.new
  file.readlines.each { |l| ec.handle(l) }
  ec.extra()
end
