File.open('01_1.input', 'r') do |file|
  file.gets
    .split('')
    .reject { |c| c != ')' and c != '(' }
    .map { |c| c == '(' ? 1 : -1 }
    .reduce(:+)
end
