require 'guidance'
require 'ui_methods'
require 'operator'

include UIMethods


Shoes.app(:title => '3W Ride', :width => 800, :height => 550, :resizable => false) do
  
  $app   = self
  $angle = 0
  Operator.new_experiment
  
  click do |button, x, y|
    Operator.robot.set_destination(x, y) if (($left..$right).include? x) && (($top..$bottom).include? y)
    Operator.robot.wheels[0].update(180, 0)
	end
  
  animate(40) do
    Operator.update_scene
  end
end