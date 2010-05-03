module Ride
  
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
  
end


Shoes.app(:title => '3W Ride', :width => 800, :height => 520, :resizable => false) do
  
  STACK_STYLE = { :margin => 5, :padding => 4 }
  
  $app = self
  
  
  @controls = stack :width => 0.25 do 
    background rgb(210, 210, 210), :curve => 20
    
    %w(First Second Third).each { |i| Ride::UIMethods.add_wheel_fields(i) }
    
    flow :margin_left => 60, :margin_top => 20 do
      button "Run" do
        
      end
    end       
  end
  
  @visualization = stack :width => 0.75 do
    background black, :curve => 12
    
    para "visualization", :stroke => white, :align => "center"
  end
  
  @controls.style(STACK_STYLE)
  @visualization.style(STACK_STYLE)
end