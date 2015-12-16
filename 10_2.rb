def look_and_say(str)
  count = 1
  number = str[0]
  res = ""
  str[1..-1].each_char do |l|
    if l == number
      count += 1
    else
      res += "#{count}#{number}"
      number = l
      count = 1
    end
  end
  res + "#{count}#{number}"
end

string = '3113322113'

50.times do |i|
  string = look_and_say(string)
  p [i, string.length]
end

string.length
