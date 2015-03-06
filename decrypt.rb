#!/usr/bin/ruby
require "Base64"
require "hex_string"



# Priority encoder
# Takes 4 bits and outputs two
# http://en.wikipedia.org/wiki/Priority_encoder
def priorityEncode(binary)
  #puts("priority encoding:" + binary.to_s)
  if binary.to_s.start_with?("1")
    return 11
  end
  if binary.to_s.start_with?("01")
    return 10
  end 
  if binary.to_s.start_with?("001")
    return 01
  end 
  if binary.to_s.start_with?("0001")
    return 00
  end 

  # by default return nothing
  return nil

end


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

puts decoded.count.to_s + " hex chunks found."
decoded = decoded.each do |data|

  # convert block of base16 (hex) into binary
  binaryChunk = data.unpack('b*')

  # output how long the binary is for each data set
  #puts binaryChunk
  #print "Binary chunk length: "
  #puts binaryChunk.to_s.length

  # break the resulting binary into chunks of 4 bits
  priorityGroups = binaryChunk.to_s.scan(/..../)
  puts priorityGroups.length.to_s + " priority groups found."

  # loop through each priority group of 4 bits and run our priority encoder on it.
  # stack the output up as a new binary pile
  priorityGroups.each do |priorityGroup|
    encodedData = priorityEncode(priorityGroup)
    if !encodedData.nil?
      #print "Priority encoder resultant binary: "
      #puts encodedData
      # add priority encoded data to new bit pile
      $encodedDataPile ||= ""
      $encodedDataPile = $encodedDataPile+ encodedData.to_s
    end
  end
end



# output
if $encodedDataPile.nil?
    puts "Can't decode."
  else
    puts "Decoded and priority encoded binary:"
    puts $encodedDataPile
end
