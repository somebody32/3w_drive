require 'wheel'

class Robot
  attr_reader :x, :y, :wheels
  
  
  def initialize
    @x, @y = $width-$left + 50, $height/2 - $top - 50
    @center_x, @center_y = @x + 50, @y + 50
    @dest_x, @dest_y = 0, 0
    
    @moving = false
    
    @wheels = []
    @wheels << Wheel.new(@center_x, @center_y-25, Math::PI/2)
    @wheels << Wheel.new(@center_x-20, @center_y+20, Math::PI/2)
    @wheels << Wheel.new(@center_x+20, @center_y+20, Math::PI/2)
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
    i = 0
    s = 0 
    @wheels.each do |w|
      s = 0.01 if i == 0
      w.update(90, s)
      dx, dy = calculate_shift(w.angle, w.momentum)
      move dx, dy
      i += 1
    end    
  end
  
  def set_destination(x, y)
		@dest_x, @dest_y = x, y
		@moving = true
	end
	
	def move(dx, dy)
    nx = @x + dx
    ny = @y + dy
    if (($left..$right).include? nx) && (($top..$bottom).include? ny)
      @x, @y = nx, ny
      @center_x, @center_y = @x + 50, @y + 50
      @wheels[0].move @center_x, @center_y-25
      @wheels[1].move @center_x-20, @center_y+20
      @wheels[2].move @center_x+20, @center_y+20
    end
	end
	
	private
  
  def calculate_shift(angle, speed)
    angle = angle + Math::PI/2
    angle = angle if (0..Math::PI/2).include? angle
    angle = Math::PI - angle if (Math::PI/2..Math::PI).include? angle
    angle = angle - Math::PI if (Math::PI..3*Math::PI/2).include? angle
    angle = 2*Math::PI - angle if (3*Math::PI/2..2*Math::PI).include? angle
    
    x_shift = Math::cos(angle)*speed
    y_shift = Math::sin(angle)*speed
    [x_shift, y_shift]
  end
  
end