class AsteroidSprite < Joybox::Core::Sprite
  # We will need access the final position later on our GameLayer
  attr_accessor :end_position

  def initialize
    @random = Random.new

    kind = @random.rand(1..4)
    file_name = "asteroid_#{kind}.png"

    screen_side = @random.rand(1..4)
    # Let's create the start and end position for our asteroid
    start_position = initial_position(screen_side)
    @end_position = final_position(screen_side)

    # Initialize the Sprite using the asteroids file image and the start position
    # This is the same as do Sprite.new file_name:, position:
    super file_name: file_name, position: start_position
  end
  # This is the maximum size of any of our asteroids, because their images are
  # rectangles only one value is needed.
  # We need this value to make sure that the asteroid will not appear on the edge
  # of the screen.
  MaximumSize = 96.0

  def initial_position(screen_side)
    case screen_side
    when 1
      # In case it spawns on the Left:
      # The X axis should be outside of the screen
      # The Y axis can be any point inside the height
      [-MaximumSize, @random.rand(1..Screen.height)]
    when 2
      # In case it spawns on the Top:
      # The X axis can be any point inside the width
      # The Y axis must be higher than the screen height
      [@random.rand(1..Screen.width), Screen.height + MaximumSize]
    when 3
      # In case it spawns on the Right:
      # The X axis must be greater than the entire screen width
      # The Y axis can by any value inside the total height
      [Screen.width + MaximumSize, @random.rand(1..Screen.height)]
    else
      # In case it spawns on the Bottom:
      # The X axis can be any value of the screen width
      # The Y axis should be lower than the total height
      [@random.rand(1..Screen.width), -MaximumSize]
    end
  end
  def final_position(screen_side)
    case screen_side
    when 1
      # In case it spawns on the Left:
      # The X axis must be bigger than the total width
      # The Y axis can be any point inside the height
      [Screen.width + MaximumSize, @random.rand(1..Screen.height)]
    when 2
      # In case it spawns on the Top:
      # The X axis can be any point inside the width
      # The Y axis must be lower than the initial screen height
      [@random.rand(1..Screen.width), -MaximumSize]
    when 3
      # In case it spawns on the Right:
      # The X axis must be lower than the start of the width
      # The Y axis can by any value inside the total height
      [-MaximumSize, @random.rand(1..Screen.height)]
    else
      # In case it spawns on the Bottom:
      # The X axis can be any value of the screen width
      # The Y axis should be higher than the total height
      [@random.rand(1..Screen.width), Screen.height + MaximumSize]
    end
  end


end