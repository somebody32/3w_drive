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
    
    @wheels = []
    @wheels << Wheel.new(@center_x, @center_y-45, 90)
    @wheels << Wheel.new(@center_x-20, @center_y+5, 0)
    @wheels << Wheel.new(@center_x+20, @center_y+5, 0)
  end
  
  def draw
    $app.fill $app.red
    $app.oval(@x, @y, 100)
    $app.fill $app.white
    @wheels.each {|w| w.draw }
  end
  
end

class Wheel
  attr_reader :x, :y

	def initialize x, y, angle
		@x, @y, @angle = x, y, angle

		$app.rotate @angle
	end

	def draw
		$app.fill $app.white
    $app.arrow(@x, @y, 20)
	end
end

class Operator
  
  def self.new_experiment
    @robot = Robot.new
  end
  
  def self.update_scene
    $app.clear do
      create_scene
      @robot.draw
    end
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
  
  $app = self
  
  Operator.new_experiment
  
  animate(60) do
    Operator.update_scene
  end
end