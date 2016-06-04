require 'open-uri'
require 'nokogiri'

module Shakespeare
  class Parser
    def initialize
      @source ||= ::Nokogiri::XML(open(source_url))
    end

    def source_url
      'http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml'
    end

    def character_array
      characters   = @source.xpath("//SPEECH/SPEAKER").to_s.gsub("<SPEAKER>" , '').gsub("</SPEAKER>" , ',').split(",")
      characters   = characters.uniq.sort_by{ |word| word.downcase}
      characters.drop(1)
    end

    def lines_per_character(character_array)
      words_for_characters = {}
      character_array.each do |speaker|
        total_words_for_character = 0
        total_words_for_character = @source.xpath("//SPEECH[SPEAKER = '#{speaker}']/LINE").to_s.gsub("<LINE>", "").gsub("</LINE>", "").split(/[^-a-zA-Z]/).each.size
        speaker.capitalize!
        words_for_characters[speaker] = total_words_for_character
      end
      words_for_characters.sort_by{ |k,v| -v}.to_h
    end
  end
end
