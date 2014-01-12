module Hamming
  def self.distance(a, b)
    a = a.each_byte
    b = b.each_byte
    a.zip(b).inject(0) do |sum, (x, y)|
      sum += (x^y).to_s(2).count('1')
      sum
    end
  end
end