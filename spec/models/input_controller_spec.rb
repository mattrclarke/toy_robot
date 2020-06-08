require_relative "../../lib/input_controller"
require_relative "../../lib/robot"
require_relative "../../lib/world"

RSpec.describe InputController do
  
  subject { InputController.new robot }
  
  let (:world) { World.new(5, 5) }
  let (:robot) { Robot.new(world) }
  
  before do 
    Robot.any_instance.stub(:gets).and_return("5")    
  end
  
  describe "execute_input" do
    
    context "when given valid input" do 
      context "when the command is available to the robot" do 
        it "sends the corresponding method to the robot" do
          command = subject.robot_commands.sample
          expect(subject.robot).to receive(:execute).once
          subject.execute_input(command)
        end
      end
      context "when the command is 'commands'" do 
        it "returns a message showing the available commands" do 
          expect(subject.execute_input('commands')).to eq(subject.commands)
        end
      end
    end
    
    context "When NOT given valid input" do 
      it "raises an error" do
        expect { subject.execute_input('foobar') }.to raise_error(InputController::InputError)
      end
    end
    
  end
  
end
