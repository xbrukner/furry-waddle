File.open("08_1.input", "r") do |file|
  extra = 0
  file.readlines.each do |l|
    extra += l.count('"\\') + 2 # starting, " and ending "; and \ is escape character, that is why it is last
  end
  extra
end
