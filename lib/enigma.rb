require "time"
class Enigma
  attr_reader :message, :key, :date

  def initialize(message)
    @message = message
  end

  def encrypt(message, key = generate_random_key, date = Time.now)

  end

  def get_final_shifts(date)
    keys = get_keys
    offsets = return_offsets(date)
    shifts = []

    4.times do |i|
      shifts << offsets[i] + keys[i]
    end

    shifts
  end

  def get_keys
    number_array = generate_random_number_array
    keys = []

    4.times do |i|
      key = number_array[i..i+1].join
      keys << key
    end

    keys.map do |key|
      key.to_i
    end
  end

  def generate_random_number_array
    random_number = rand(100000)
    string_rand = '%05d' % random_number

    string_rand.split("").map do |char|
      char.to_i
    end
  end

  def return_offsets(date)
    f_date = return_date_formatted(date)
    last_four = square_formatted_date_return_last_4(f_date)
    offsets = last_four.split("")

    offsets.map do |i|
      i.to_i
    end
  end

  def return_date_formatted(date)
    year = "#{date.year}"
    month = "#{date.month}"
    day = "#{date.day}"

    month.prepend("0") if month.length == 1

    date_as_string = day + month + year[-2..-1]
    date_as_string.to_i
  end

  def square_formatted_date_return_last_4(formatted_date)
    squared = formatted_date * formatted_date
    squared_as_string = squared.to_s

    squared_as_string[-4..-1]
  end
end
