#!/usr/bin/env ruby
# FieldMatter::Tag

# requires

class FieldMatter
  
  class Tag
    counter :total
    
    def self.[](id)
      super(encode(id)) || create(:id => encode(id))
    end
  end
end