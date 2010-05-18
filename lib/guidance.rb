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
	
	def compensate_angle(angle, target_angle)
	  k = 1
	  sigma = 100 
	  d = 1.5
	  delta = 0.001
	  ksi = [0, 0]
	  st = 0.005
	  ksi[0] = ksi[1]
	  error = target_angle - angle
	  ksi[1] = ksi[0] + st * sigma * (error - ksi[0])
	  u = k * (ksi[0] + sigma * (error - ksi[0]))
	  
	  
	  u += d if u > delta
	  u -= d if u < -delta
	    
	  u = 0.01  if u > 0.01
	  u = -0.01 if u < -0.01
	  
	  u
  end
end