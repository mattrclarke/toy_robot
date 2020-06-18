require 'byebug'
class InputController
  class InputError < StandardError; end
  
  def initialize
    @robot, @world = nil
    get_world_size
    get_robot_position
    commands
  end
      
  def execute_input(command)
    case command
    when 'commands'
      commands
    when 'quit'
      exit
    when 'report'
      p @robot.report
    else
      @robot.execute(command)
      print_string_array(@robot.get_map)
    end
  end
  
  private 
  
  def get_world_size
    loop do 
      p "Enter a width for the world"
      @width = gets.chomp.to_i
      p "Enter a height for the world"
      @height = gets.chomp.to_i
      
      valid_generator_input?(@width, @height) ? break : invalid_input_message
    end
    @world = World.new(@width, @height)
  end
  
  def get_robot_position
    loop do 
      p "Enter an x coordinate to place the robot"
      @x_coords = gets.chomp.to_i
      p "Enter a y coordinate to place the robot"
      @y_coords = gets.chomp.to_i
      
      valid_generator_input?(@x_coords, @y_coords) ? break : invalid_input_message
    end
      @robot = Robot.new(@world, @y_coords, @x_coords)
  end
      
  def commands
    puts "\n \n #{"-" * 40}
    This program will accept the following input:\n
    'move' will move the robot forward in current facing direction \n
    'left or 'right' will turn the robot. \n
    'report' will return the robot's current position\n
    'commands' will show the available commands\n
    'exit' will quit the program \n
    #{"-" * 40}"
  end
  
  def valid_generator_input?(input_1, input_2)
    input_1.to_i >= 1 && input_2.to_i >= 1
  end
  
  def invalid_input_message
    p "Inputs must both be numbers greater than 1"
  end
  
  def print_string_array(array)
    array.each{ |row| puts row }
  end
  
end
