require 'rubygems'
require 'daemons'

Daemons.run File.join(File.dirname(__FILE__), 'video-workerd.rb')
