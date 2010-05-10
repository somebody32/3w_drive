module Guidance
	def guidance_system x, y, dest_x, dest_y, angle
		vx, vy = dest_x - x, dest_y - y
		if vx.abs < 0.1 and vy.abs <= 0.1
			yield 0, 0
		else
			length = Math.sqrt(vx * vx + vy * vy)
			vx /= length
			vy /= length
			ax, ay = Math.cos(angle), Math.sin(angle)
			cos_between = vx * ax + vy * ay
			sin_between = vx * -ay + vy * ax
			yield sin_between, cos_between
		end
	end
end


module UIMethods
  LEFT_MARGIN = 12

  def self.add_wheel_fields(wheel_no)
    $app.tagline "#{wheel_no} wheel", :margin_bottom => 5, :margin_top => 15, :padding => 0, :align => 'center'

    $app.inscription 'Angle',    :margin => 0, :margin_left => LEFT_MARGIN
    $app.edit_line               :margin => 0, :margin_left => LEFT_MARGIN-4, :width => 100
    $app.inscription 'Momentum', :margin => 0, :margin_left => LEFT_MARGIN
    $app.edit_line               :margin => 0, :margin_left => LEFT_MARGIN-4, :width => 100
  end
end

class Robot
  attr_reader :x, :y, :wheels
  
  
  def initialize
    @x, @y = $width-$left + 50, $height/2 - $top - 50
    @center_x, @center_y = @x + 50, @y + 50
    @dest_x, @dest_y = 0, 0
    
    @moving = false
    
    @wheels = []
    @wheels << Wheel.new(@center_x, @center_y-25, 0)
    @wheels << Wheel.new(@center_x-20, @center_y+20, 0)
    @wheels << Wheel.new(@center_x+20, @center_y+20, 0)
  end
  
  def draw
    $app.stroke $app.red
    $app.fill $app.red(0.3)
    $app.oval(@x, @y, 100)
    $app.fill $app.white
    @wheels.each {|w| w.draw }
    
    if @moving
      $app.stroke $app.green
			$app.fill $app.green(0.2)
			$app.oval @dest_x-10, @dest_y-10, 20
    end
  end
  
  def update
    @wheels.each {|w| w.update(@dest_x, @dest_y) }
  end
  
  def set_destination(x, y)
		@dest_x, @dest_y = x, y
		@moving = true
	end
  
end

class Wheel
  include Guidance
  attr_reader :x, :y, :angle

	def initialize x, y, angle
		@x, @y, @angle = x, y, angle + 2*Math::PI
		@dest_x, @dest_y = 0, 0
	end

	def draw
		$app.rotate((@angle-$angle)*180.0/Math::PI)
		$app.debug((@angle-$angle)*180.0/Math::PI)
		$app.fill $app.white
	  $app.star @x, @y, 3, 10, 5
	  $app.star @x, @y, 1, 10, 5
    $angle = @angle
	end
	
	def update(x, y)
	  @dest_x, @dest_y = x, y
	  
	  guidance_system @x, @y, @dest_x, @dest_y, @angle do |direction, on_target|
			aim direction
		end
	end
	
	def aim direction
		@angle += [[-0.1, direction].max, 0.1].min
	end
end

class Operator
  
  def self.new_experiment
    create_scene
    @robot = Robot.new
  end
  
  def self.update_scene
    robot.update
    $app.clear do
      create_scene
      @robot.draw
    end
  end
  
  def self.robot
    @robot
  end
  
  def self.create_scene
    @controls = $app.stack :width => 0.25 do 
      $app.background rgb(210, 210, 210), :curve => 20

      %w(First Second Third).each { |i| UIMethods.add_wheel_fields(i) }

      $app.flow :margin_left => 60, :margin_top => 20 do
        $app.button "Run" do

        end
      end       
    end

    @visualization = $app.stack :width => 0.75 do
      $app.background $app.black, :curve => 12    
      $app.para "visualization", :stroke => $app.white, :align => "center"
    end

    @controls.style(STACK_STYLE)
    @visualization.style(STACK_STYLE)

    $width, $height =  @visualization.width,  @visualization.height 

    $left   = $app.width  - @visualization.width - 5
    $right  = $left  + @visualization.width
    $top    = 5
    $bottom = $app.height - 5
  end  
end


Shoes.app(:title => '3W Ride', :width => 800, :height => 520, :resizable => false) do
  
  STACK_STYLE = { :margin => 5, :padding => 4 }
  
  $app   = self
  $angle = 0
  Operator.new_experiment
  
  click do |button, x, y|
    Operator.robot.set_destination(x, y) if (($left..$right).include? x) && (($top..$bottom).include? y)
	end
  
  animate(40) do
    Operator.update_scene
  end
end