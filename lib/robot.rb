require_relative "movement_controller"
class Robot  
  class MovementError < StandardError; end
  class PlacementError < StandardError; end
  
  attr_accessor :movement_controller, :world
  
  def initialize(world)
    @world = world
    @movement_controller
    place_robot
  end
  
  def execute(command)
    raise PlacementError.new "Robot has not been placed" if !!!@movement_controller
    self.send(command) if !!@movement_controller
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
  
  private
  def place_robot
    p "enter an x coordinate to place the robot"
    @x_coords = gets.chomp.to_i
    p "enter a y coordinate to place the robot"
    @y_coords = gets.chomp.to_i
    @movement_controller = MovementController.new(@y_coords, @x_coords, 0, @world)
    @world.is_valid_position?(@y_coords, @x_coords)
  end

end
