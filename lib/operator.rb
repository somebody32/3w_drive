require 'robot'

class Operator
  include UIMethods
  STACK_STYLE = { :margin => 5, :padding => 4 }

  
  def self.new_experiment
    @wheel_array = [[90, 0],[90, 0],[90, 0]]
    create_scene    
    @robot = Robot.new
  end
  
  def self.update_scene
    robot.update(@wheel_array)
    $app.clear do
      create_scene
      robot.draw
    end
  end
  
  def self.robot
    @robot
  end
  
  def self.create_scene
    @controls = $app.stack :width => 0.25 do 
      $app.background rgb(210, 210, 210), :curve => 20

      %w(first second third).each_with_index { |w,i| UIMethods.add_wheel_fields(w, @wheel_array[i]) }

      $app.flow :margin_left => 30, :margin_top => 20 do
        $app.button "Run" do
          $running = true
          %w(first second third).each_with_index do |w, i|
            @wheel_array[i] = [eval("@@#{w}_angle.text").to_i, eval("@@#{w}_momentum.text").to_i]
          end
        end
        $app.button "Stop" do
          $running = false
        end
      end
      
      if robot
        3.times do |w|
          $app.inscription "#{w+1} a:#{self.robot.wheels[w].int_angle} s:#{self.robot.wheels[w].momentum.to_i}", :align => "center", :margin => 0
        end
      end
    end

    @visualization = $app.stack :width => 0.75 do
      $app.background $app.white, :curve => 12    
      $app.para "visualization", :stroke => $app.white, :align => "center"
    end

    @controls.style(STACK_STYLE)
    @visualization.style(STACK_STYLE)

    $width, $height =  @visualization.width,  @visualization.height 

    $left   = $app.width  - @visualization.width + 5
    $right  = $left  + @visualization.width
    $top    = 5
    $bottom = $app.height
  end 
end