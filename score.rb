class Score
  def self.score s
    LetterFreq.new(s).score + WordLength.new(s).score
  rescue ArgumentError => e
    if e.message =~ /invalid byte sequence/
      -999.0
    else
      raise e
    end
  end

  def initialize s
    @s = s
  end

  def text_without_space_and_punctuation
    @s.gsub /[.|,|'| ]/, ''
  end
end

require_relative 'letter_freq'
require_relative 'word_length'
