#!/usr/bin/env ruby
# FieldMatter
# Author: Fielding Johnston

# bundler
require "bundler/setup"

# external
require "grit"
require "json"

# internal 
require File.expand_path('../fieldmatter/strangematter', __FILE__)
require File.expand_path('../fieldmatter/darkmatter', __FILE__)
require File.expand_path('../fieldmatter/note', __FILE__)
require File.expand_path('../fieldmatter/tag', __FILE__)
require File.expand_path('../fieldmatter/version', __FILE__)

class FieldMatter

  def initialize # eventually define common attr here and inherit to DarkMatter and StrangeMatter

  end
end



