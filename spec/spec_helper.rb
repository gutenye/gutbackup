require "oldtime"

$spec_dir = File.expand_path("..", __FILE__)
$spec_data = File.expand_path("../data", __FILE__)

Rc.p.home = Pa("#{$spec_data}/oldtime")
Rc.p.homerc = Pa("#{$spec_data}/oldtimerc")



