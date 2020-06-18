require "byebug"
class MovementController

  class MovementError < StandardError; end
  attr_accessor :direction, :current_position, :world, :coords
  COMPASS = ["north", "east", "south", "west"].freeze
  
  def initialize(y_coords, x_coords, direction, world)
    @direction = direction
    @y_coords = y_coords
    @x_coords = x_coords
    @coords = { y: @y_coords, x: @x_coords }
    @world = world
  end
      
  def left
    @direction = (facing == 'north' ? (COMPASS.length - 1) : @direction - 1)
  end

  def right
    @direction = (facing == 'west' ? 0 : @direction + 1)
  end

  def attempt_move
    new_position(@coords)
  end

  def report
    "#{facing.capitalize} #{[@coords[:y], @coords[:x]]}"
  end
  
  def coordinates_exist?(y, x)
    if @world.is_valid_position?(y, x) == false
      raise MovementError.new "Position is not on table"
    end
  end
  
  def generate_map
     map = @world.generate_world.map do |row|
      row_string = ""
      row.each do |coordinate|
        tile = [coordinate][0] == [@coords[:y], @coords[:x]] ? "0-0" : "---"
        row_string << tile
      end
      row_string
    end
    map.reverse
  end
  
  private
  def facing
    @facing = COMPASS[@direction]
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