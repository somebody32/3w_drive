module UIMethods
  LEFT_MARGIN = 12
  
  def self.add_wheel_fields(wheel_no, i)
    $app.tagline "#{wheel_no.capitalize} wheel", :margin_bottom => 5, :margin_top => 15, :padding => 0, :align => 'center'

    $app.inscription 'Angle',    :margin => 0, :margin_left => LEFT_MARGIN
    eval("@@#{wheel_no}_angle = $app.edit_line :margin => 0, :margin_left => LEFT_MARGIN-4, :width => 100, :text => i[0]")
    $app.inscription 'Speed', :margin => 0, :margin_left => LEFT_MARGIN
    eval("@@#{wheel_no}_momentum = $app.edit_line :margin => 0, :margin_left => LEFT_MARGIN-4, :width => 100, :text => i[1]")
  end
  
  def self.check_borders(x, y, left = $left, right = $right, top = $top, bottom = $bottom)
    ((left..right).include? x) && ((top..bottom).include? y)
  end
end