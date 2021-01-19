module Readable
  def read(filename)
    message = File.open(filename, 'r')
    cypher_text = message.read.chomp
    message.close

    cypher_text
  end

  def write(filename, message)
    writer = File.open(filename, 'w')
    writer.write(message)
    writer.close
  end
end
