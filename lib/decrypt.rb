require './lib/readable'
require './lib/displayable'
require './lib/enigma'
include Readable
include Displayable

enigma = Enigma.new
text = Readable.read(ARGV[0])
decrypted_hash = enigma.decrypt(text, ARGV[2], ARGV[3])
Readable.write(ARGV[1], decrypted_hash[:decryption])
p Displayable.display(ARGV[1], decrypted_hash[:key], decrypted_hash[:date])
