require './lib/readable'
require './lib/displayable'
require './lib/enigma'
include Readable
include Displayable

enigma = Enigma.new
text = Readable.read(ARGV[0])
encrypted_hash = enigma.encrypt(text)
Readable.write(ARGV[1], encrypted_hash[:encryption])
p Displayable.display(ARGV[1], encrypted_hash[:key], encrypted_hash[:date])
