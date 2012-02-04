#!/usr/bin/env ruby
# FieldMatter
# Author: Fielding Johnston

# bundler
require "bundler/setup"

# external
require "grit"
require "JSON"

# internal 
#Dir['fieldMatter/*.rb'].sort.each { |lib| require lib }
require File.expand_path('../fieldMatter/strangeMatter', __FILE__)
require File.expand_path('../fieldMatter/darkMatter', __FILE__)
require File.expand_path('../fieldMatter/note', __FILE__)
require File.expand_path('../fieldMatter/tag', __FILE__)
require File.expand_path('../fieldMatter/version', __FILE__)

class FieldMatter

  def initialize

  end
end



