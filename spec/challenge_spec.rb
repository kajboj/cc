require 'pry'
require_relative '../lib/utils'
require_relative '../lib/xor'

describe '1' do
  let(:hex) do
    to_bin '49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d'
  end

  let(:base64) {'SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t'}

  specify { encode64(hex).should == base64 }
  specify { decode64(base64).should == hex }
end

describe '2' do
  let(:s1)       { to_bin '1c0111001f010100061a024b53535009181c' }
  let(:s2)       { to_bin '686974207468652062756c6c277320657965' }
  let(:expected) { to_bin '746865206b696420646f6e277420706c6179' }

  specify { xor(s1, s2).should == expected }
end

describe '3' do
  let(:encoded) {to_bin '1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736'}
  specify do
    decode_single_char_xor(encoded)

    encoded = to_bin(File.read('data/one_xor_encrypted.txt').chomp)
    File.open('test.txt', 'w') do |f|
      f.puts decode_single_char_xor(encoded)
    end
  end
end

describe '5' do
  let(:plain) do
    "Burning 'em, if you ain't quick and nimble\nI go crazy when I hear a cymbal"
  end

  let(:expected) { to_bin '0b3637272a2b2e63622c2e69692a23693a2a3c6324202d623d63343c2a26226324272765272a282b2f20430a652e2c652a3124333a653e2b2027630c692b20283165286326302e27282f' }

  specify do
    xor = Xor.new('ICE')
    encrypted = xor.encrypt plain
    encrypted.should == expected
  end
end

describe 'Hamming distance' do
  let(:s1) {'this is a test'}
  let(:s2) {'wokka wokka!!!'}

  specify do
    Hamming.distance(s1, s2).should == 37
  end
end
