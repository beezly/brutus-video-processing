require 'gearman'

$ENCODING_PATH = '/var/encode/'
$GEARMAN_SERVER = 'brutus.shef.ac.uk'

client = Gearman::Client.new($GEARMAN_SERVER)
taskset = Gearman::TaskSet.new(client)
task = Gearman::Task.new('encode', ARGV[0])
p task
taskset.add_task(task)
p taskset
