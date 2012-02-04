#!/usr/bin/env ruby
# FieldMatter
# Author: Fielding Johnston

# external
require 'grit'
require 'JSON'

# internal
require File.expand_path('../fieldMatter/strangeMatter', __FILE__)
require File.expand_path('../fieldMatter/darkMatter', __FILE__)
require File.expand_path('../fieldMatter/note', __FILE__)
require File.expand_path('../fieldMatter/tag', __FILE__)


class FieldMatter

  def initialize

  end
end


#fieldmatter = Xattr.new("#{file}")
#tags_as_json = fieldmatter.as_json

matter = FieldMatter::StrangeMatter.new('/Users/fielding/notes')
repo = Grit::Repo.new(matter.repo_path)
files_to_update = repo.status.changed                            # let's grab the changed file information
files_to_update.delete(".gitignore")
files_to_update.delete("fieldMatter.json")                             
files_to_update.keys.each { | file | matter.mdluvin ( file) }    # Grab keys, which are file names that changed, and for each one show it some mdluvin
#puts "These tags matter: "
#p matter.tags_matter
puts "What Matters? AKA What matters to extended attributes"
p matter.what_matters
json_matters = JSON.generate(matter.what_matters)



File.open("#{matter.repo_path}/fieldMatter.json", "w") do |f|
  f.write(json_matters)
end

puts "Thank you, your JSON has been written to fieldMatter.json"

