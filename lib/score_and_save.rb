require_relative 'utils'

class ScoreAndSave
  def initialize infile, outfile
    @infile, @outfile = infile, outfile
    @all
  end

  def run
    load_all
    score
    sort
    save
  end

  def load_all
    @all = []
    File.read(@infile).each_line do |line|
      @all << line.chomp
    end
  end

  def score
    i = 0
    @all.each_with_index do |plain, i|
      score = Score.score plain
      @all[i] = [score, plain]
      puts i if i % 1000 == 0
      i += 1
    end
  end

  def sort
    @all.sort_by! do |scored|
      score = scored.first
      score.nan? ? -999.0 : score
    end.reverse!
  end

  def save
    File.open(@outfile, 'w') do |out|
      @all.each do |scored|
        out.puts format(scored)
      end
    end
  end

  def format scored
    score = sprintf "%.3f", scored.first
    "#{score}: #{scored.last}"
  end
end

ScoreAndSave.new('one_xor_decrypted.txt', 'scored.txt').run
