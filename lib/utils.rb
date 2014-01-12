require "base64"
require_relative 'score'
require_relative 'hamming'

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

def decode_single_char_xor bin
  all = 255.times.map do |i|
    single_char = pack [i]*bin.size
    xor single_char, bin
  end

  candidates = all.select do |s|
    s =~ /\A[a-zA-Z ,.']*\z/
  end

  scores = candidates.map { |p| score p }
  max = scores.max

  scores.zip(candidates).find do |score, plaintext|
    return plaintext if score == max
  end
end

def score plaintext
  Score.score plaintext
end