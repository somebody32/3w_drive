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