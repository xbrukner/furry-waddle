def ribbon(lengths)
  wrap = lengths.sort.take(2).reduce(:+) * 2
  bow = lengths.reduce(:*)
  wrap + bow
end
File.open('02_1.input', 'r') do |file|
  file.readlines
    .map {|line| ribbon(line.split('x').map(&:to_i)) }
    .reduce(:+)
end
