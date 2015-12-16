File.open("09_1.input", "r") do |file|
  distances = Hash.new { |hash, e| hash[e] = Hash.new }

  file.readlines.each do |l|
    /([^ ]*) to ([^ ]*) = (\d+)/.match(l) do |m|
      distances[m[1]][m[2]] = m[3].to_i
      distances[m[2]][m[1]] = m[3].to_i
    end
  end

  res = 0
  distances.keys.permutation do |p|
      c = 0
      p.reduce { |from, to| c += distances[from][to]; to }
      if c > res then
        res = c
      end
  end
  res
end
