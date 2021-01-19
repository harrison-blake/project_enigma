require "time"

class Enigma
  attr_reader :character_set

  def initialize
    @character_set = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
                     "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]
  end

  def encrypt(message, key = return_random_key_as_string, date = return_date_formatted_string(Time.now))
    encrypt_hash = {
                    :encryption => "",
                    :key => key,
                    :date => date
                   }

    last_four = square_date_as_string_return_last_4(date)
    offsets = return_offsets(last_four)
    final_keys = key_as_string_to_final_key(key)
    shifts = get_final_shifts(final_keys, offsets)
    count = 3

    encrypt_hash[:encryption] = message.split("").map do |character|
      count = (count + 1) % shifts.length
      index = @character_set.index(character) + shifts[count]
      index = index % @character_set.length
      @character_set[index]
    end.join("")

    encrypt_hash
  end

  def decrypt(cypher_text, key, date = return_date_formatted_string(Time.now))
    decrypt_set = @character_set.reverse
    decrypt_hash = {
                    :decryption => "",
                    :key => key,
                    :date => date
                   }
    last_four = square_date_as_string_return_last_4(date)
    offsets = return_offsets(last_four)
    final_keys = key_as_string_to_final_key(key)
    shifts = get_final_shifts(final_keys, offsets)
    count = 3

    decrypt_hash[:decryption] = cypher_text.split("").map do |character|
      count = (count + 1) % shifts.length
      index = decrypt_set.index(character) + shifts[count]
      index = index % decrypt_set.length
      decrypt_set[index]
    end.join("")

    decrypt_hash
  end

  def get_final_shifts(keys, offsets)
    shifts = []

    4.times do |i|
      shifts << offsets[i] + keys[i]
    end

    shifts
  end

  def return_offsets(last_four)
    offsets = last_four.split("")

    offsets.map do |i|
      i.to_i
    end
  end

  def key_as_string_to_final_key(key_as_string)
    keys = []

    4.times do |i|
      keys << key_as_string[i..i+1]
    end

    keys.map do |key|
      key.to_i
    end
  end

  def return_random_key_as_string
    number_array = generate_random_number_array
    number_array.join.to_s
  end

  def generate_random_number_array
    random_number = rand(100000)
    string_rand = '%05d' % random_number

    string_rand.split("").map do |char|
      char.to_i
    end
  end

  def return_date_formatted_string(date)
    year = "#{date.year}"
    month = "#{date.month}"
    day = "#{date.day}"

    day.prepend("0") if day.length == 1
    month.prepend("0") if month.length == 1

    date_as_string = day + month + year[-2..-1]
  end

  def square_date_as_string_return_last_4(date_as_string)
    squared = date_as_string.to_i * date_as_string.to_i
    squared_as_string = squared.to_s

    squared_as_string[-4..-1]
  end
end
