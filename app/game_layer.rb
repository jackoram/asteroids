class GameLayer < Joybox::Core::Layer
  scene
 
  
  def on_enter
    background = Sprite.new file_name: 'background.png',
        position: Screen.center
    self << background
    
    @score = 0
    @duration = 10.0
    
    @label = Label.new text: "#{@score}"
    @label.position = [Screen.width - 100 , Screen.height - 75]
    @label.font_size = 50
    self << @label
    
    @timer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector:'timerFired', userInfo:nil, repeats:true)

    @rocket = Sprite.new file_name: 'rocket.png', position: Screen.center, 
        alive: true
    self << @rocket

    # The following block will be called when the user touches the screen
    on_touches_began do |touches, event|
      touch = touches.any_object
      # The move action will update the rocket position frame by frame until it
      # arrives at the desired location
      @rocket.run_action Move.to position: touch.location
    end
    
    # The game loop will call the following block every time it passes, regularly
     # sixty times per second.
     schedule_update do |dt|
       launch_asteroids

       show_score

       # The following method is not implemented yet
       # We only need to call this method if the Rocket is still alive, its value
       # was defined when the @rocket sprite was created
       check_for_collisions if @rocket[:alive]
     end
    
    
  end

  def timerFired
      @score = @score + 1
      @timer.invalidate if @score <=0 
      
      # Every 10 sec, create them faster
      @duration = @duration - 1.0 if @score % 10 == 0
      
    end  
  
  def show_score
    @label.text = "#{@score}"
  end
  
  # Defines the max. number of asteroids that can be on the screen at the same time.
  MaximumAsteroids = 10

  def launch_asteroids
    @asteroids ||= Array.new

    if @asteroids.size <= MaximumAsteroids
      missing_asteroids = MaximumAsteroids - @asteroids.size

      # Loop create 10 asteriods
      missing_asteroids.times do
        asteroid = AsteroidSprite.new

        # First we need to create the Move action
        r = Random.new.rand(5..9) * 0.1 
        move_action = Move.to(position: asteroid.end_position, duration: (@duration * r))
        
        # Second using the Callback action we create a block that will remove the
        # asteroid from the array. As you may notice the block will receive as
        # parameter the sprite that run the action
        callback_action = Callback.with { |asteroid| @asteroids.delete asteroid }

        # Finally we run both actions in sequence first the Move action and then
        # the Callback one.
        asteroid.run_action Sequence.with actions: [move_action, callback_action]

        self << asteroid
        @asteroids << asteroid
      end
      
    end
  end
  
  def check_for_collisions
    # Iterate through every asteroid in the screen
    @asteroids.each do |asteroid|
      # Check if it's bounding box intersects with the rocket
      if CGRectIntersectsRect(asteroid.bounding_box, @rocket.bounding_box)
        # If true finish the game
        # First stop the movement on all of the asteroids
        @asteroids.each(&:stop_all_actions)

        # Set the alive property of the rocket to false, this to avoid that the
        # collision is checked again
        @rocket[:alive] = false
        # Give the rocket a nice retro blink!
        @rocket.run_action Blink.with times: 20, duration: 3.0
        BubbleWrap::App.delegate.audio_effect.play(:explodingpigs)
        
        #STOP THE COUNTDOWN!!!!!!
        
        @timer.invalidate
        
        play = MenuLabel.new text: 'Play again' do |menu_item|
            # This block is called when the Menu Label is selected  
            Joybox.director.pop_scene
        end

        menu = Menu.new position: [Screen.half_width, Screen.half_height], items: [play]
        self << menu
        
        break
      end
    end
  end
  
  
  
  
  
  
end