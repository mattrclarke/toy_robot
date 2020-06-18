require 'byebug'
require_relative "movement_controller"
class Robot  
  
  attr_accessor :movement_controller, :world
  
  def initialize(world, y_coords, x_coords)
    @movement_controller = nil
    @world = world
    
    place_robot(y_coords, x_coords)
  end
  
  def execute(command)
    raise ArgumentError.new("Robot says 'Command does not compute'") if self.respond_to?(command) == false
    
    self.send(command)
  end

  def place_robot(y_coords, x_coords)
    @movement_controller = MovementController.new(y_coords, x_coords, 0, @world)
  end
    
  def move
    @movement_controller.attempt_move
  end

  def left
    @movement_controller.left
  end

  def right
    @movement_controller.right
  end

  def report
    @movement_controller.report
  end
  
  def get_map
    @movement_controller.generate_map
  end

end
