# FieldMatter::StrangeMatter

# require

class FieldMatter
  class StrangeMatter
    attr_reader :repo, :repo_path, :tags_matter

    def initialize ( repo_path )
      @repo_path = repo_path
      @tags_matter = Hash.new
    end

    def as_json ( object )
      JSON.generate(object)
    end

    def update
      changes = self.repo.status.changed        # Determine files/objects in the git repo that have been flagged for update
      
      changes.delete(".gitignore")              # Any non-tagged/tag-important files that aren't ignored in .gitignore or info/exclude 
      changes.delete("fieldMatter.json")        # are potential problems/waste of database space. This will delete them if they turn up.
      
      changes.keys.each do |file|               # for each file that has changed
        self.mdluvin( file )                    # show these files some mdluvin; aka get a list of extended attribute openmeta tags from mdls.
      end
      
      self.write_to_json                                        
    end

    def repo
      Grit::Repo.new(self.repo_path)            # Grab repo object using Grit
    end

    def mdluvin ( file )
      file_path = self.repo_path + '/' + file
      tags = %x{mdls -name 'kMDItemOMUserTags' -raw "#{file_path}"|awk '/[^()]/ {print $NF}'|tr -d '\n'}.split(',')
      puts "Updating tags associated with #{file}: #{tags}"
      # Possibly temporary, might change the array/hash construction to different methods
      @tags_matter.store(file, tags)
    end

    def what_matters
      what_matters = Hash.new
      @tags_matter.each do | filename, tags |
        strange_matter = Hash['kMDItemOMUserTags' => tags]
        what_matters.store(filename, strange_matter)
      end

    return what_matters
    end

    def write_to_json
      json_matters = self.as_json( self.what_matters )
      File.open("#{self.repo_path}/fieldMatter.json", "w") do |f|
        f.write(json_matters)
      end
    end
  end
end