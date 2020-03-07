class RobotController
  attr_accessor :x_coords, :y_coords, :direction_index, :current_position, :compass, :reporting

  def initialize(y_coords = 0, x_coords = 0, world_height, world_width)
    @y_coords = y_coords
    @x_coords = x_coords
    @world_height = world_height
    @world_width = world_width
    @direction_index = 0
    @reporting = false
  end

  # We need a way to show a cardinal direction and iterate through possible
  # directions - this is done using the compass.
  # The robots direction_index stores the current position in the compass
  def compass
    ["north", "east", "south", "west"]
  end

  def position
    [@y_coords, @x_coords]
  end

  def robot_can_move?
    # We need to prevent the robot from leaving the world_grid
    return false if facing_direction == "north" && @y_coords == 0
    return false if facing_direction == "east"  && @x_coords == @world_width
    return false if facing_direction == "south" && @y_coords == @world_height
    return false if facing_direction == "west"  && @x_coords == 0
    true
  end

  def move
    return unless robot_can_move?
    case facing_direction
    when 'north' then @y_coords -= 1
    when 'south' then @y_coords += 1
    when 'east'  then @x_coords += 1
    when 'west'  then @x_coords -= 1
    end
  end

  # North south etc strings are stored in an array created when instantiating a robot.
  # The variable dir holds an interger which is used as the array index to cycle through
  def turn( turn_direction )
    if turn_direction == 'left'
      turn_left
    else turn_direction == 'right'
      turn_right
    end
  end

  def turn_left
    if facing_direction == 'north'
      @direction_index = 3
    else
      @direction_index -= 1
    end
  end

  def turn_right
    if facing_direction == 'west'
      @direction_index = 0
    else
      @direction_index += 1
    end
  end

  def report
    if @reporting == true
      puts "#{compass[@direction_index].capitalize} #{[@x_coords, @y_coords]}"
    end
  end

  def show_direction_arrow
    case compass[@direction_index]
    when 'north' then p "Facing \u21e7 "
    when 'east' then p "Facing \u21e8 "
    when 'south' then p "Facing \u21e9 "
    when 'west' then p "Facing \u21e6 "
    end
  end

  def facing_direction
    compass[@direction_index]
  end


end
