#!/usr/bin/env ruby
# fieldMatter
# Author: Fielding Johnston

require 'ffi-xattr'
require 'grit'
require 'JSON'

class FieldTheory
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
  #construct fieldmatter object with tags and other needed xattrs
  #object should look like what_matters{'filename' => { XattrNAme => 'string' or array['of', 'string']}}
  return what_matters
  end

end


#fieldmatter = Xattr.new("#{file}")
#tags_as_json = fieldmatter.as_json

matter = FieldTheory.new('/Users/fielding/notes')
repo = Grit::Repo.new(matter.repo_path)
files_to_update = repo.status.changed                     # let's grab the changed file information
files_to_update.delete("Interim Note-Changes")            # remove "Interim Note-Changes" from the list
files_to_update.keys.each { | file | matter.mdluvin ( file) }    # Grab keys, which are file names that changed, and for each one show it some mdluvin
#puts "These tags matter: "
#p matter.tags_matter
puts "What Matters? Aka What matters to extended attributes"
p matter.what_matters
json_matters = JSON.generate(matter.what_matters)



File.open("fieldMatter.json", "w") do |f|
  f.write(json_matters)
end

puts "Thank you, your JSON has been written to fieldMatter.json"

