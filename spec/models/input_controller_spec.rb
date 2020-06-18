require_relative "../../models/input_controller"
require_relative "../../models/robot"
require_relative "../../models/world"

RSpec.describe InputController do
  
  subject { InputController.new }
  
  let (:world) { World.new(5, 5) }
  let (:robot) { Robot.new(world, 4, 4) }
  
  before do 
    Robot.any_instance.stub(:gets).and_return("5")    
  end
  
  describe "execute_input" do
    
    context "when given valid input" do 
      
      context "when the command is move" do 
        it "sends the corresponding method to the robot" do
          command = "move"
          expect(subject.robot).to receive(:execute).with(command)
          subject.execute_input(command)
        end
      end
      
      context "when the command is left" do 
        it "sends the corresponding method to the robot" do
          command = "left"
          expect(subject.robot).to receive(:execute).with(command)
          subject.execute_input(command)
        end
      end
      
      context "when the command is right" do 
        it "sends the corresponding method to the robot" do
          command = "right"
          expect(subject.robot).to receive(:execute).with(command)
          subject.execute_input(command)
        end
      end
      
      context "when the command is report" do 
        it "sends the corresponding method to the robot" do
          command = "report"
          expect(subject.robot).to receive(:execute).with(command)
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
