require 'rubygems'
require 'gearman'

$ENCODING_PATH = '/var/encode'
$VIDEO_PATH = '/var/videos'
$GEARMAN_SERVER = 'brutus.shef.ac.uk'

w = Gearman::Worker.new($GEARMAN_SERVER)

w.add_ability('encode') do |path, job|
  base_name = path.sub /\.mov$/, ''
  `ffmpeg2theora "#{$ENCODING_PATH}/#{path}"`
  d = Dir.new $ENCODING_PATH
  ogg_path = d.glob("#{base_name}.og?")[0]
  File.rename "#{$ENCODING_PATH}/#{path}", "#{$VIDEO_PATH}/#{ogg_path}"
  File.delete "#{$ENCODING_PATH}/#{path}"
end

loop { w.work } 
