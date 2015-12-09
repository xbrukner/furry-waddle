File.open('01_1.input', 'r') do |file|
  data = file.gets
    .split('')
    .reject { |c| c != ')' and c != '(' }
    .map { |c| c == '(' ? 1 : -1 }
  position = 0
  count = 0
  while count > -1 do
    count += data.shift
    position += 1
  end
  position
end
