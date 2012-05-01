require 'gearman'

$ENCODING_PATH = '/var/encode/'
$GEARMAN_SERVER = 'brutus.shef.ac.uk'

w = Gearman::Worker.new($GEARMAN_SERVER)

w.add_ability('encode') do |path, job|
  puts 'Processing #{path} #{job}'
  Dir.chdir($ENCODING_PATH)
  `ffmpeg2theora "#{$ENCODING_PATH}/#{path}"`
  puts 'Completed ${path}'
end

loop { w.work } 
