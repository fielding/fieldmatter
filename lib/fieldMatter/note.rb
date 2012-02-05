# FieldMatter:Note

# requires
require 'ohm'
require 'ohm/contrib'

class FieldMatter
  
  class Note < Ohm::Model
    include Ohm::Callbacks

    attribute :filename
    attribute :tags
    index :tag
    index :filename

    def tag(tags = self.tags)
      return tags
    end
  
    # I don't full understand callbacks, so this is fubar. Will try to fix soon
  protected
    def before_save
     # tag(read_remote(:tags)).map(&Tag).each { |t| t.decr :total}
    end

    def after_save
      #tag.map(&Tag).each { |t| t.incr :total}
    end
  end
end
