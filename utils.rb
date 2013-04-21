require "base64"
require_relative 'score'

def pack array
  array.pack 'C*'
end

def to_bin string
  b = []
  s = string.split ''
  while s.any?
    b.unshift s.pop(2).join.hex
  end
  pack b
end

def encode64 bin
  Base64.strict_encode64 bin
end

def decode64 base64
  Base64.strict_decode64 base64
end

def xor a, b
  a = a.each_byte
  b = b.each_byte

  xored = a.zip(b).map { |x, y| x^y }
  pack xored
end

def dist a, b
  a = a.each_byte
  b = b.each_byte
  a.zip(b).inject(0) do |sum, (x, y)|
    sum += (x^y).to_s(2).count('1')
    sum
  end
end
