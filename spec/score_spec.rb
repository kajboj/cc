require 'pry'
require_relative '../lib/score'

describe Score do
  def s text
    Score.score(text)
  end

  specify do
    s('hello').should > s('zzzzz')
  end

  specify do
    s('Sentence with sensible word lengths.').should >
      s('Sentencewithsensiblewordlengths.')
  end

  specify do
    s('English text with normal character distribution').should >
      s('Englishz textz withz normalz characterz distributionz')
  end
end
