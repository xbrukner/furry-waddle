require 'digest/md5'
string = 'iwrupvqb'
number = 1
while Digest::MD5.hexdigest(string + number.to_s)[0..4] != ("0" * 5) do
  number += 1
end
number
