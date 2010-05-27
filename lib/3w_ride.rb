#!/usr/bin/env open -a Shoes.app
require 'guidance'
require 'ui_methods'
require 'operator'

include UIMethods

Shoes.app(:title => '3W Ride', :width => 800, :height => 550, :resizable => false) do
  
  $app   = self
  $angle = 0
  $running = false
  Operator.new_experiment
  
  click do |button, x, y|
    Operator.robot.set_destination(x, y) if UIMethods.check_borders(x, y)
	end
  
  animate(40) do
    Operator.update_scene if $running
  end
end