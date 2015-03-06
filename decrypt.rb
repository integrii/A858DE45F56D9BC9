#!/usr/bin/ruby
require "Base64"
require "hex_string"


# read user input to get file name
print "Open which file? "
targetFile = gets.chomp

# read file
path = Dir.pwd + "/"  +targetFile
file = open(path,"r")
content = file.read

# Decoding
puts "Decoding:"
puts content

#decoded = Base64.decode64(content)
decoded = content.split(" ")
decoded = decoded.each do |data|

  puts "--"
  # convert block of base16 (hex) into binary
  binaryChunk = data.unpack('b*')
  # output how long the binary is for each data set
  puts binaryChunk
  print "Binary chunk length: "
  puts binaryChunk.to_s.length

end



# output
if decoded.nil?
    puts "Can't decode."
  else
    #puts "Decoded:"
    #puts decoded
end
