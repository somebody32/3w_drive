require 'wheel.rb'

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