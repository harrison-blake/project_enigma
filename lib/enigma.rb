class Enigma
  attr_reader :message, :key, :date

  def initialize(message, key = nil, date = nil)
    @message = message
    @key = key
    @date = date
  end

  def generate_random_key
    random_number = rand(100000)
    '%05d' % random_number
  end
end
