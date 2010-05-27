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
      w.update(wheels_array[i][0], wheels_array[i][1])
      dx, dy = calculate_shift(w.angle, w.momentum)
      move dx, dy
    end    
  end
  
  def set_destination(x, y)
		@dest_x, @dest_y = x, y
		@moving = true
	end
	
	def move(dx, dy)
    nx = @x + dx
    ny = @y + dy
    if (($left..$right).include? nx) && (($top..$bottom-100).include? ny)
      @x, @y = nx, ny
      @center_x, @center_y = @x + 50, @y + 50
      @wheels[0].move @center_x, @center_y-25
      @wheels[1].move @center_x-20, @center_y+20
      @wheels[2].move @center_x+20, @center_y+20
    end
	end
	
	private
  
  def calculate_shift(angle, speed)
    angle += Math::PI/2
    
    angle, x_sign, y_sign = case angle
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
  
end