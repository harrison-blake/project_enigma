require 'minitest/autorun'
require 'minitest/pride'
require './lib/enigma'

class EnigmaTest < Minitest::Test
  def setup
    @enigma = Enigma.new("Hello World")
  end

  def test_enigma_attributes

    assert_instance_of Enigma, @enigma
    assert_equal "Hello World", @enigma.message
    assert_nil @enigma.key, @enigma.date
  end

  def test_generate_random_key

    assert_equal 5, @enigma.generate_random_key.length
  end
end
