class LetterFreq < Score
  def initialize s
    @s = s.downcase
  end

  def score
    score = 0
    average_freq.each do |letter, av_freq|
      actual_freq = freq[letter]
      score -= (av_freq - actual_freq).abs
    end
    score
  end

  private

  def freq
    return @freq if @freq

    @freq = {}

    letters.each do |letter|
      @freq[letter] = @s.count(letter).to_f / count_without_space_and_punctuation
    end

    @freq
  end

  def count_without_space_and_punctuation
    text_without_space_and_punctuation.size
  end

  def average_freq
    @average_freq ||= eval File.read('lib/frequency.rb')
  end

  def letters
    average_freq.keys
  end
end
