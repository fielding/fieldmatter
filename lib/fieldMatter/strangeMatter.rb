#!/usr/bin/env ruby
# FieldMatter::StrangeMatter

# require

class FieldMatter
  class StrangeMatter
    attr_reader :repo_path, :tags_matter

    def initialize ( repo_path )
      @repo_path = repo_path
      @tags_matter = Hash.new
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
  end
end