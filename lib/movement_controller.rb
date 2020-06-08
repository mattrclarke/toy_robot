class MovementController
  require "byebug"
  class MovementError < StandardError; end
  attr_accessor :direction, :current_position, :world, :coords, :compass

  def initialize(y_coords, x_coords, direction, world)
    @direction = direction
    @y_coords = y_coords
    @x_coords = x_coords
    @coords = { y: @y_coords, x: @x_coords }
    @world = world
    @compass = ["north", "east", "south", "west"]
  end
      
  def left
    @direction = (facing == 'north' ? (@compass.length - 1) : @direction - 1)
  end

  def right
    @direction = (facing == 'west' ? 0 : @direction + 1)
  end

  def attempt_move
    new_position(@coords)
  end

  def report
    p "#{facing.capitalize} #{[@coords[:y], @coords[:x]]}"
  end
  
  def coordinates_exist?(y, x)
    if @world.is_valid_position?(y, x) == false
      raise MovementError.new "Position is not on table"
    end
  end
  
  private
  
  def facing
    @facing = @compass[@direction]
  end
  
  def new_position(coords = {})
    coords[:y] += 1 if facing == 'north' 
    coords[:y] -= 1 if facing == 'south' 
    coords[:x] += 1 if facing == 'east'  
    coords[:x] -= 1 if facing == 'west'  
    
    coordinates_exist?(coords[:y], coords[:x])    
    return coords
  end

end