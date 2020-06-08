class InputController
  attr_reader :robot
  class InputError < StandardError
  end
  
  def initialize(robot)
    @robot = robot
  end

  def input_commands
    ["commands", "quit"]
  end
  
  def robot_commands
    ["move", "left", "right", "report"]
  end

  def commands
    puts "\n \n#{"-" * 40}
    This program will accept the following input:\n
    'move' will move the robot forward in current facing direction \n
    'left or 'right' will turn the robot. \n
    'report' will return the robot's current position\n
    'commands' will show the available commands\n
    'exit' will quit the program \n
    #{"-" * 40}"
  end

  def execute_input(command)
    
    if (input_commands + robot_commands).include?(command) == false
      raise InputError.new("Invalid command entered")
    end

    @robot.execute(command) if @robot.respond_to?(command)
    commands if command == "commands"
    exit if command == "quit"
  end
end
