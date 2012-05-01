require 'gearman'

$ENCODING_PATH = '/var/encode/'
$VIDEO_PATH = '/var/videos/'
$GEARMAN_SERVER = 'brutus.shef.ac.uk'

w = Gearman::Worker.new($GEARMAN_SERVER)

w.add_ability('encode') do |path, job|
  Dir.chdir($VIDEO_PATH)
  `ffmpeg2theora "#{$ENCODING_PATH}/#{path}"`
end

loop { w.work } 
