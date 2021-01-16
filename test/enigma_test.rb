require 'minitest/autorun'
require 'minitest/pride'
require './lib/enigma'
require 'mocha/minitest'

class EnigmaTest < Minitest::Test
  def setup
    @enigma = Enigma.new("Hello World")
  end

  def test_enigma_attributes
    assert_instance_of Enigma, @enigma
    assert_equal "Hello World", @enigma.message
  end

  def test_generate_random_number_array
    assert_equal 5, @enigma.generate_random_number_array.length
  end

  def test_return_date_formatted_custom_date
    time = Time.new(1995, 8, 4)

    assert_equal 40895, @enigma.return_date_formatted(time)
  end

  def test_return_date_formatted_date_now
    time = Time.now

    assert_equal 150121, @enigma.return_date_formatted(time)
  end

  def test_square_formatted_date_return_last_4
    time = Time.new(1995, 8, 4)
    formatted_date = @enigma.return_date_formatted(time)

    assert_equal "1025", @enigma.square_formatted_date_return_last_4(formatted_date)
  end

  def test_return_offsets
    date = Time.new(1995, 8, 4)

    assert_equal [1, 0, 2, 5], @enigma.return_offsets(date)
  end

  def test_get_keys
    @enigma.stubs(:generate_random_number_array).returns([0,2,7,1,5])

    assert_equal [02, 27, 71, 15], @enigma.get_keys
  end

  def test_get_final_shifts
    date = Time.new(1995, 8, 4)
    @enigma.stubs(:generate_random_number_array).returns([0,2,7,1,5])

    assert_equal [3, 27, 73, 20], @enigma.get_final_shifts(date)
  end
end
