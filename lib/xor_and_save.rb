require_relative 'utils'

class XorAndSave
  def initialize infile, outfile
    @infile, @outfile = infile, outfile
  end

  def decrypt_all
    File.open(@outfile, 'w') do |out|
      i = 0
      File.read(@infile).each_line do |line|
        bin = to_bin line.chomp
        all = decode_single_char_xor(bin)
        all.each do |plain|
          out.write plain
          out.write "\n"
        end
        puts i if i % 10 == 0
        i += 1
      end
    end
  end

  def decode_single_char_xor bin
    255.times.map do |i|
      single_char = pack [i]*bin.size
      xor single_char, bin
    end
  end
end

xas = XorAndSave.new('from_gist.txt', 'one_xor_decrypted.txt')

xas.decrypt_all
