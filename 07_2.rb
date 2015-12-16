class Circuit
  def initialize
    @gates = Hash.new
  end

  def num_or_const(str)
    if str =~ /\A\d+\Z/
      str.to_i
    else
      if @gates[str].respond_to? :call
        #Evaluate only once
        @gates[str] = val = @gates[str].call()
      else
        @gates[str]
      end
    end
  end

  def handle(line)
    matched = false
    /([a-z]+|[0-9]+) \-\> ([a-z]+)/.match(line) do |m|
      @gates[m[2]] = lambda { num_or_const(m[1]) }
      matched = true
    end
    /([a-z]+|[0-9]+) AND ([a-z]+|[0-9]+) \-\> ([a-z]+)/.match(line) do |m|
      @gates[m[3]] = lambda { num_or_const(m[1]) & num_or_const(m[2]) }
      matched = true
    end
    /([a-z]+|[0-9]+) OR ([a-z]+|[0-9]+) \-\> ([a-z]+)/.match(line) do |m|
      @gates[m[3]] = lambda { num_or_const(m[1]) | num_or_const(m[2]) }
      matched = true
    end
    /NOT ([a-z]+|[0-9]+) \-\> ([a-z]+)/.match(line) do |m|
      @gates[m[2]] = lambda { ~num_or_const(m[1]) }
      matched = true
    end
    /([a-z]+|[0-9]+) LSHIFT ([0-9]+) \-\> ([a-z]+)/.match(line) do |m|
      @gates[m[3]] = lambda { (num_or_const(m[1]) << m[2].to_i) & 65535 } #Do not go over 16 bits
      matched = true
    end
    /([a-z]+|[0-9]+) RSHIFT ([0-9]+) \-\> ([a-z]+)/.match(line) do |m|
      @gates[m[3]] = lambda { (num_or_const(m[1]) >> m[2].to_i) }
      matched = true
    end
    if !matched then
      puts "Line not matched: #{line}"
      exit
    end
  end

  def get(wire)
    num_or_const(wire)
  end
end


File.open('07_1.input', 'r') do |file|
  c = Circuit.new
  d = Circuit.new
  file.readlines
    .each { |str| c.handle(str); d.handle(str) }
  a = c.get('a')
  d.handle("#{a} -> b")
  puts "a: #{d.get('a')}"
end
