def isNice(line)
  invalid = ["ab", "cd", "pq", "xy"].map { |e| line.include?(e) ? 1 : 0 }.reduce(:+)
  if invalid > 0 then return false end
  vowels = line.count "aeiou"
  if vowels < 3 then return false end
  found = false
  line.split('').reduce do |prev, succ|
    if prev == succ then found = true end
    succ
  end
  found
end
File.open('05_1.input', 'r') do |file|
  file.readlines
   .map { |line| isNice(line) ? 1 : 0 }
   .reduce(:+)
end
