# FieldMatter::Tag

# requires
require 'ohm'

class FieldMatter
  
  class Tag < Ohm::Model
    counter :total
    
    def self.[](id)
      super(encode(id)) || create(:id => encode(id))
    end
  end
end