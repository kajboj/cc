class Xor
  def initialize key
    @key = key
  end

  def encrypt bin
    xor \
      repeating_key(bin.length),
      bin
  end

  private

  def repeating_key length
    ''.ljust(length, @key)
  end
end
