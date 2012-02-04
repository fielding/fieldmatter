#!/usr/bin/env ruby

require 'grit'          # 
require 'JSON'          #
require 'ohm'           # Used by fieldMatter:Note and fieldMatter:Tag
require 'ohm/contrib'   # Used by fieldMatter:Note

class FieldMatter
  class DarkMatter
    attr_reader :repo_path, :repo, :what_matters
    
    def initialize( repo_path )
      @repo_path = repo_path
    end

    def repo
      Grit::Repo.new(self.repo_path)
    end

    def what_matters # get new tag updates from fieldMatter.json
      JSON.parse((self.repo.tree / 'fieldMatter.json').data)
    end

  end

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

  class Tag < Ohm::Model
    counter :total
    
    def self.[](id)
      super(encode(id)) || create(:id => encode(id))
    end
  end
end




# testbed - need to refactor still, but will check for existing and then create or update depending
  dm = FieldMatter::DarkMatter.new('/Users/fielding/notes')
  dm.what_matters.each do | key, value |
    if not FieldMatter::Note.find(filename: key).empty?
      puts "that file exists, let's update it"   # debug helper
      canon = Base64.encode64(key).chomp 
      id = Ohm.redis.smembers("FieldMatter::Note:filename:#{canon}").pop
      note = FieldMatter::Note[id]
      note.update(:tags => value['kMDItemOMUserTags'])
    else
      puts "file doesn't exist, let's create it" 
    FieldMatter::Note.create(:filename => key, :tags => value['kMDItemOMUserTags'])
    end
  end
