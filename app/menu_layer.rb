class MenuLayer < Joybox::Core::Layer
  scene
  

  def on_enter
    background = Sprite.new file_name: 'background.png',
        position: Screen.center
    self << background
    
    start = MenuLabel.new text: 'Start the Game!' do |menu_item|
        # This block is called when the Menu Label is selected  
        puts "start here"
        
        # This line tells the director to present our Layer when the game starts
        scene = GameLayer.scene
        Joybox.director.push_scene scene
    end
    quit = MenuLabel.new text: 'Quit!' do |menu_item|
        # This block is called when the Menu Label is selected  
        puts "quit"
        exit
    end

    menu = Menu.new position: [Screen.half_width, Screen.half_height], items: [start, quit]
    menu.align_items_in_rows [1, 1]
    self << menu
  end


end