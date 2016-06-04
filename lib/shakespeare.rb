require_relative 'shakespeare/parser'

module Shakespeare
end

class_instance   = Shakespeare::Parser.new
character_array  = class_instance.character_array
sorted_line_hash = class_instance.lines_per_character(character_array)

sorted_line_hash.each do |key, value|
  puts "#{value}: #{key}"
end
