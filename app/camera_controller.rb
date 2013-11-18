class CameraController < AVClubController
  

  def viewDidLoad
    super
    view_finder = UIView.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    self.view.addSubview(view_finder)
    start_in_view(view_finder)
   
    @title_label = init_label
    self.view.addSubview( @title_label)
    
     club_timer(@title_label, 5) do
       club_timer(@title_label, 10) { @club.stopRecording }
       @club.startRecording
     end
     
    end
    
  def club_timer( label, start_time , &block )
    t = start_time - 1

    count_down = EM.add_periodic_timer 1.0 do
      label.text = t.to_s
      
      
      if t == 0
         block.call
         EM.cancel_timer(count_down)
      end
       t = t -1
    end
  end
  
  def init_label
    half_width = (Device.screen.width / 2)
    
    label = UILabel.alloc.initWithFrame([[(half_width-10),15], [20,20]])
    label.textColor = UIColor.whiteColor
    
    label
  end

  def willRotateToInterfaceOrientation(to_interface_duration, duration:duration)
    super

    case to_interface_duration
    when UIInterfaceOrientationLandscapeLeft
      new_frame = CGRect.new([0, 0], [480, 320])
    when UIInterfaceOrientationLandscapeRight
      new_frame = CGRect.new([0, 0], [480, 320])
    when UIInterfaceOrientationPortrait
      new_frame = CGRect.new([0, 0], [320, 480])
    when UIInterfaceOrientationPortraitUpsideDown
      new_frame = CGRect.new([0, 0], [320, 480])
    end

    ### important ###
    rotate_camera_to(new_frame, orientation:to_interface_duration, duration:duration)
  end

end
