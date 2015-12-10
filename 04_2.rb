require 'digest/md5'
string = 'iwrupvqb'
number = 1
length = 6
while Digest::MD5.hexdigest(string + number.to_s).slice(0, length) != ("0" * length) do
  number += 1
end
number
