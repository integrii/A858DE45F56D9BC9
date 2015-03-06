#!/usr/bin/ruby
require "Base64"
require "hex_string"


# read user input to get file name
print "Open which file? "
targetFile = gets.chomp

# read file
path = Dir.pwd + "/"  +targetFile
file = open(path,"r")
contents = file.read

# Decoding
puts "Decoding:"
puts contents
decoded = Base64.decode64(contents)
#decoded encoded decoded.to_byte_string


# output
if decoded.nil?
    puts "Can't decode."
  else
    puts "Decoded:"
    puts decoded
end
