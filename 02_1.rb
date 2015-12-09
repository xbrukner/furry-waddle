def wrapper(s1, s2, s3)
  areas = [s1 * s2, s2 * s3, s1 * s3]
  areas.min + 2 * areas.reduce(:+)
end
File.open('02_1.input', 'r') do |file|
  file.readlines
    .map {|line| wrapper(*line.split('x').map(&:to_i)) }
    .reduce(:+)
end
