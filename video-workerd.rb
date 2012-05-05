require 'rubygems'
require 'gearman'
require 'fileutils'

$ENCODING_PATH = '/var/encode'
$VIDEO_PATH = '/var/videos/encoded'
$GEARMAN_SERVER = 'brutus.shef.ac.uk'

w = Gearman::Worker.new($GEARMAN_SERVER)

w.add_ability('encode') do |path, job|
  base_name = path.sub /\.mov$/, ''
  `ffmpeg -i "#{$ENCODING_PATH}/#{path}" -vcodec libtheora -qscale 5 "#{$VIDEO_PATH}/#{base_name}.ogv" -vcodec libx264 -qscale 5 "#{$VIDEO_PATH}/#{base_name}.mp4"`
  File.delete "#{$ENCODING_PATH}/#{path}"
end

loop { w.work } 
