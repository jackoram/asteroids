class AppDelegate
  
  attr_accessor :audio_effect

  def applicationWillResignActive(app)
    @director.pause if @navigation_controller.visibleViewController == @director
  end

  def applicationDidBecomeActive(app)
    @director.resume if @navigation_controller.visibleViewController == @director
  end

  def applicationDidEnterBackground(app)
    @director.stop_animation if @navigation_controller.visibleViewController == @director
  end

  def applicationWillEnterForeground(app)
    @director.start_animation if @navigation_controller.visibleViewController == @director
  end

  def applicationWillTerminate(app)
    @director.end
  end

  def applicationDidReceiveMemoryWarning(app)
    @director.purge_cached_data
  end

  def applicationSignificantTimeChange(app)
    @director.set_next_delta_time_zero true
  end
  
  def application(application, didFinishLaunchingWithOptions:launchOptions)

    @director = Joybox::Configuration.setup do
      director display_stats: true
    end

    @navigation_controller =
        UINavigationController.alloc.initWithRootViewController(@director)
    @navigation_controller.navigationBarHidden = true

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.setRootViewController(@navigation_controller)
    @window.makeKeyAndVisible

    # This line tells the director to present our Layer when the game starts
    @director << MenuLayer.scene

    @audio_effect = Joybox::Audio::AudioEffect.new
    @audio_effect.add(effect: :crash ,file_name: 'sfx.wav')
    @audio_effect.add(effect: :explodingpigs ,file_name: 'sfx2.wav')
    @audio_effect.play(:crash)
    puts "plain sound"
    
    true
  end


end

