require_relative "utils"

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
