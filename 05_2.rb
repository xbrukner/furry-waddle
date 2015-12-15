def isNice(line)
  if line.length == 0 then return false end
  double = false
  between = false
  (0..line.length - 1).each do |start|
    if start + 4 <= line.length then
      if line[start + 2..-1].include? line[start, 2] then
        double = true
      end
    end
    if start + 3 <= line.length then
      if line[start] == line[start + 2] then
        between = true
      end
    end
  end
  double and between
end
File.open('05_1.input', 'r') do |file|
  file.readlines
   .map { |line| isNice(line.chomp) ? 1 : 0 }
   .reduce(:+)
end
