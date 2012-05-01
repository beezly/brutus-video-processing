require 'rubygems'
require 'gearman'
require 'fileutils'

$ENCODING_PATH = '/var/encode'
$VIDEO_PATH = '/var/videos'
$GEARMAN_SERVER = 'brutus.shef.ac.uk'

w = Gearman::Worker.new($GEARMAN_SERVER)

w.add_ability('encode') do |path, job|
  base_name = path.sub /\.mov$/, ''
  `ffmpeg2theora "#{$ENCODING_PATH}/#{path}"`
  ogg_path = Dir.glob("#{$ENCODING_PATH}/#{base_name}.og?")[0]
  FileUtils.mv ogg_path, "#{$VIDEO_PATH}"
  File.delete "#{$ENCODING_PATH}/#{path}"
end

loop { w.work } 
