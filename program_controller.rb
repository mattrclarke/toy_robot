require_relative "world_controller"
require_relative "robot_controller"
require_relative "input_controller"
require_relative "string"
require 'byebug'
module ToyRobot
  class ProgramController

    def initialize
      @world_grid = build_world
      @robot = RobotController.new(@world.height, 0, @world.height, @world.width)
      @input_controller = InputController.new(@robot)
    end

    def run
      show_gui
      @input_controller.commands
      @world.is_first_render = false
      gameplay
    end

    def gameplay
      loop do
        print "\nEnter a command:"
        command = gets.chomp.downcase
        system('clear')
        break if command == 'quit'
        @input_controller.execute_input(command)
        show_gui
      end
    end

    def build_world
      p "Enter a integer for the height of the world"
      height = gets.chomp.to_i
      p "Enter a integer for the width of the world"
      width = gets.chomp.to_i
      @world = WorldController.new(width, height)
      @world.generate_world
    end

    def show_gui
      @robot.report
      @robot.show_direction_arrow
      @world.show_world(@world_grid, [@robot.y_coords, @robot.x_coords])
    end

  end
end

ToyRobot::ProgramController.new.run
