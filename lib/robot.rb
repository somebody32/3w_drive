require 'wheel'

class Robot
  attr_reader :x, :y, :wheels
  
  
  def initialize
    set_center($width-$left + 50, $height/2 - $top - 50)
    @dest_x, @dest_y = 0, 0
    @dest_angle = Math::PI/2
    
    @moving = false
    
    @wheels = []
    @wheels << Wheel.new(@center_x, @center_y-25, @dest_angle)
    @wheels << Wheel.new(@center_x-20, @center_y+20, @dest_angle)
    @wheels << Wheel.new(@center_x+20, @center_y+20, @dest_angle)
  end
  
  def draw
    $app.stroke $app.black
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
  
  def update(wheels_array)    
    @wheels.each_with_index do |w, i|
      update_angle = @moving ? @dest_angle : wheels_array[i][0]
      w.update(update_angle, wheels_array[i][1])
      dx, dy = calculate_shift(w.angle, w.momentum)
      move dx, dy
    end    
  end
  
  def set_destination(x, y)
		@dest_x, @dest_y = x, y
		dist_x, dist_y = @dest_x-@center_x, @dest_y-@center_y
		
		@dest_angle = if dist_x > 0
		  if dist_y < 0
		     Math.asin(dist_y/Math.hypot(dist_x, dist_y)).abs
	    else
	      2*Math::PI - Math.asin(dist_y/Math.hypot(dist_x, dist_y))
      end
	  else
	    if dist_y < 0
	      Math::PI/2 + Math.asin((dist_x)/Math.hypot(dist_x, dist_y)).abs
	    else
	      Math::PI + Math.asin((dist_y)/Math.hypot(dist_x, dist_y))
      end
    end
    @dest_angle = @dest_angle*180.0/Math::PI
    @moving = true
	end
	
	def move(dx, dy)
    nx = @x + dx
    ny = @y + dy
    if UIMethods.check_borders(nx, ny)
      set_center(nx, ny)
      @wheels[0].move @center_x, @center_y-25
      @wheels[1].move @center_x-20, @center_y+20
      @wheels[2].move @center_x+20, @center_y+20
    end
	end
	
	private
  
  def calculate_shift(angle, speed)
    angle += Math::PI/2
    
    angle, x_sign, y_sign = case angle.abs
      when 0..Math::PI/2
        [angle, "+", "-"]
      when Math::PI/2..Math::PI
        [Math::PI - angle, "-", "-"]
      when Math::PI..3*Math::PI/2
        [angle - Math::PI, "-", "+"]
      when 3*Math::PI/2..2*Math::PI
        [2*Math::PI - angle, "+", "+"]
    end
    x_shift = eval("#{x_sign}Math::cos(angle)*speed")
    y_shift = eval("#{y_sign}Math::sin(angle)*speed")
    [x_shift, y_shift]
  end
  
  def set_center(x, y)
    @x, @y = x, y
    @center_x, @center_y = @x + 50, @y + 50  
  end
  
end