require './test/test_helper'
require './lib/enigma'
require 'mocha/minitest'

class EnigmaTest < Minitest::Test
  def setup
    @enigma = Enigma.new
  end

  def test_instance_of_and_attributes
    set = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
           "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]

    assert_instance_of Enigma, @enigma
    assert_equal set, @enigma.character_set
  end

  def test_generate_random_number_array
    assert_equal 5, @enigma.generate_random_number_array.length
  end

  def test_return_date_formatted_string_custom_date
    time = Time.new(1995, 8, 4)

    assert_equal "040895", @enigma.return_date_formatted_string(time)
  end

  def test_return_date_formatted_string_date_now
    time = Time.now

    assert_equal "190121", @enigma.return_date_formatted_string(time)
  end

  def test_square_date_as_string_return_last_4
    time = Time.new(1995, 8, 4)
    date = @enigma.return_date_formatted_string(time)

    assert_equal "1025", @enigma.square_date_as_string_return_last_4(date)
  end

  def test_return_offsets
    time = Time.new(1995, 8, 4)
    date = @enigma.return_date_formatted_string(time)
    last_four = @enigma.square_date_as_string_return_last_4(date)

    assert_equal [1, 0, 2, 5], @enigma.return_offsets(last_four)
  end

  def test_return_random_key_as_string
    @enigma.stubs(:generate_random_number_array).returns([0,2,7,1,5])

    assert_equal "02715", @enigma.return_random_key_as_string
  end

  def test_key_as_string_to_final_key
    key = "02715"

    assert_equal [02, 27, 71, 15], @enigma.key_as_string_to_final_key(key)
  end

  def test_get_final_shifts
    time = Time.new(1995, 8, 4)
    @enigma.stubs(:generate_random_number_array).returns([0,2,7,1,5])
    key = "02715"
    date = @enigma.return_date_formatted_string(time)
    last_four = @enigma.square_date_as_string_return_last_4(date)
    offsets = @enigma.return_offsets(last_four)
    final_keys = @enigma.key_as_string_to_final_key(key)

    assert_equal [3, 27, 73, 20], @enigma.get_final_shifts(final_keys, offsets)
  end

  def test_encrypt_specified_key_and_date
    time = Time.new(1995, 8, 4)
    date = @enigma.return_date_formatted_string(time)

    answer_hash = {
                   encryption: "keder ohulw",
                   key: "02715",
                   date: "040895"
                  }

    assert_equal answer_hash, @enigma.encrypt("hello world", "02715", date)
  end

  def test_encrypt_specified_key
    answer_hash = {
                   encryption: "no",
                   key: "02715",
                   date: @enigma.return_date_formatted_string(Time.now)
                  }

    assert_equal answer_hash, @enigma.encrypt("hi", "02715")
  end

  def test_encrypt_random
    @enigma.stubs(:generate_random_number_array).returns([1,2,7,1,7])
    answer_hash = {
                   encryption: "xo",
                   key: "12717",
                   date: @enigma.return_date_formatted_string(Time.now)
                  }

    assert_equal answer_hash[:encryption], @enigma.encrypt("hi")[:encryption]
    assert_equal answer_hash[:key], @enigma.encrypt("hi")[:key]
    assert_equal answer_hash[:date], @enigma.encrypt("hi")[:date]
  end

  def test_decrypt_with_and_date
    answer_hash = {
                   decryption: "hello world",
                   key: "02715",
                   date: "040895"
                  }

    assert_equal answer_hash, @enigma.decrypt("keder ohulw", "02715", "040895")
  end

  def test_decrypt_no_date
    @enigma.stubs(:generate_random_number_array).returns([1,2,7,1,7])
    answer_hash = {
                   decryption: "hi",
                   key: "12717",
                   date: @enigma.return_date_formatted_string(Time.now)
                  }
    test = @enigma.decrypt("xo", "12717")

    assert_equal answer_hash, test
  end
end
