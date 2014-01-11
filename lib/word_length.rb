class WordLength < Score
  def initialize s
    @s = s
  end

  def score
    -(average_word_length - english_average).abs
  end

  private

  def average_word_length
    words = @s.split(' ')
    words.inject(0) do |a, word|
      a += word.size
    end.to_f / words.size
  end

  def english_average
    5.2
  end
end
