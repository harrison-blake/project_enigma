require './test/test_helper'
require './lib/displayable'
include Displayable

class DisplayableTest < Minitest::Test
  def test_display_encrypted
    filename = "test.txt"
    key = "02715"
    date = "040895"

    answer = "Created 'test.txt' with the key 02715 and date 040895"

    assert_equal answer, Displayable.display(filename, key, date)
  end
end
