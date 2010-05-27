class Wheel
  include Guidance
  attr_reader :x, :y, :angle, :momentum
  
	def initialize x, y, angle
		@x, @y = x, y
		self.angle = angle
		@momentum = 0
		
		@dest_angle = angle
		@dest_momentum = 0
	end

	def draw
		$app.rotate((@angle-$angle)*180.0/Math::PI)
		$app.fill $app.white
	  $app.rect @x-5, @y-5, 10, 10
	  $app.line @x, @y-5, @x, @y+5
    $angle = @angle
	end
	
	def move(x, y)
	  @x, @y = x, y
	end
	
	def angle=(val)
	  @angle = val - Math::PI/2
	end
	
	def update(angle, momentum)
	  @dest_angle, @dest_momentum = angle/180.0*Math::PI - Math::PI/2, momentum
	  
	  next_angle = compensate_angle(@angle, @dest_angle)
	  aim next_angle
	  
	  next_speed = compensate_momentum(@momentum, @dest_momentum)
	  boost next_speed
	end
	
	def aim direction
		@angle += [[-0.1, direction].max, 0.1].min
	end
	
	def boost speed
	  @momentum += [[-0.01, speed].max, 0.01].min
	end
	
	def int_angle
	  ((@angle + Math::PI/2)*180.0/Math::PI).to_i
	end
end