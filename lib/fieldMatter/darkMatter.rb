# FieldMatter::DarkMatter

# require
require 'grit'          # 
require 'JSON'          #
require 'ohm'           # Used by fieldMatter:Note and fieldMatter:Tag
require 'ohm/contrib'   # Used by fieldMatter:Note

class FieldMatter
  
  class DarkMatter
    attr_reader :repo, :repo_path, :what_matters
    
    def initialize( repo_path )
      @repo_path = repo_path
    end

    def repo
      Grit::Repo.new(self.repo_path)
    end

    def what_matters # get new tag updates from fieldMatter.json
      JSON.parse((self.repo.tree / 'fieldMatter.json').data)
    end

    def update 
      self.what_matters.each do | key, value |
        if not FieldMatter::Note.find(filename: key).empty?
          canon = Base64.encode64(key).chomp
          id = Ohm.redis.smembers("FieldMatter::Note:filename:#{canon}").pop
          note = FieldMatter::Note[id]
          note.update(:tags => value['kMDItemOMUserTags'])
        else
          FieldMatter::Note.create(:filename => key, :tags => value['kMDItemOMUserTags'])
        end
      end
    end
  end
end


# testbed - need to refactor still, but will check for existing and then create or update depending
#  dm.what_matters.each do | key, value |
#    if not FieldMatter::Note.find(filename: key).empty?
#      puts "that file exists, let's update it"   # debug helper
#      canon = Base64.encode64(key).chomp 
#      id = Ohm.redis.smembers("FieldMatter::Note:filename:#{canon}").pop
#      note = FieldMatter::Note[id]
#      note.update(:tags => value['kMDItemOMUserTags'])
#    else
#      puts "file doesn't exist, let's create it" 
#    FieldMatter::Note.create(:filename => key, :tags => value['kMDItemOMUserTags'])
#    end
#  end


