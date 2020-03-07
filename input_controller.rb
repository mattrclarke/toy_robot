class InputController
  attr_reader :robot

  def initialize(robot)
    @robot = robot
  end

  def available_commands
    ["move", "left", "right", "commands", "report"]
  end

  def commands
    puts "\n \n#{"-" * 40}
    Robot accepts the folling commands:\n
    'Move' or 'm' will move forward in current direction \n
    'Left or 'Right' will turn respectively. \n
    'Report' will return the robots current position\n
    'Controls' will show the available commands\n
    'Quit' to exit \n
    #{"-" * 40}".light_blue
  end

  def execute_input(command)
    @robot.reporting = false

    @robot.move             if command == "move" || command == "m"
    @robot.turn(command)    if command == "left" || command == "right"
    @robot.reporting = true if command == "report"
    commands                if command == "commands"

    if available_commands.include?(command) == false
      p "Enter 'commands' to see a list of available commands"
    end
  end
end
