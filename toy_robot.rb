require_relative "models/world"
require_relative "models/robot"
require_relative "models/input_controller"

module ToyRobot
  class ProgramController

    def initialize
      @input_controller = InputController.new
      run
    end

    private
    def run      
      loop do
        print "\nEnter a command:"
        command = gets.chomp.downcase
        system('clear')
        @input_controller.execute_input(command)
      end
    end
  end
end

ToyRobot::ProgramController.new
