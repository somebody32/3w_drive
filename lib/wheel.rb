class Wheel
  include Guidance
  attr_reader :x, :y, :angle

	def initialize x, y, angle
		@x, @y, @angle = x, y, angle + 2*Math::PI
		@dest_x, @dest_y = 0, 0
	end

	def draw
		$app.rotate((@angle-$angle)*180.0/Math::PI)
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