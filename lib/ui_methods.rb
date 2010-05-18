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