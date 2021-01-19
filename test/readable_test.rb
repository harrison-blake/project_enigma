require './test/test_helper'
require './lib/readable'
include Readable

class ReadableTest < Minitest::Test
  def test_read_file
    text = Readable.read("test_message.txt")

    assert_equal "hello world", text
  end

  def test_write_file
    text = Readable.read("test_message.txt")
    Readable.write("write_test.txt", text)
    message = Readable.read("write_test.txt")

    assert_equal "hello world", message
  end
end
