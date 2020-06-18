require_relative "../../models/world"
require_relative "../../models/robot"
RSpec.describe Robot do

  subject { Robot.new @world }
  
  before do
    Robot.any_instance.stub(:gets).and_return("5")
    random_size = rand(4..15)
    @world = World.new(random_size, random_size)
  end
  
  describe "#execute" do
    context "when the robot has a movement controller instantiated" do
      it "calls execute on the robot's movement controller" do
        subject.movement_controller = MovementController.new(0, 0, 0, @world)
        expect(subject.movement_controller).to receive(:attempt_move).once
        subject.execute("move")
      end
    end
    
    context "when the robot does NOT have a movement controller instantiated" do
      it "returns a message" do
        subject.movement_controller = nil
        expect { subject.execute("move") }.to raise_error(Robot::PlacementError)
      end
    end
  end
  
  describe "#move" do 
    it "calls move on the robot's movement controller" do
      expect(subject.movement_controller).to receive(:attempt_move).once
      subject.move
    end
  end
  
  describe "#left" do 
    it "calls left on the robot's movement controller" do 
      subject.left
      expect(subject.movement_controller).to receive(:left).once
      subject.left
    end
  end
  
  describe "#right" do 
    it "calls right on the robot's movement controller" do 
      expect(subject.movement_controller).to receive(:right).once
      subject.right
    end
  end
  
  describe "#report" do 
    it "calls report on the robot's movement controller" do 
      expect(subject.movement_controller).to receive(:report).once
      subject.report
    end
  end
  
  describe "#place_robot" do 
    
    it "takes user input" do
      allow(subject).to receive(:gets) { "5" }
      expect(subject).to receive(:gets).twice
      subject.movement_controller = nil
      subject.send(:place_robot)
    end
    
    it "initialises a movement controller" do
      Robot.any_instance.stub(:gets).and_return("5")
      subject.movement_controller = nil
      subject.send(:place_robot)
      expect(subject.movement_controller.coords).to eq({y: 5, x: 5})
    end
    
    
    it "calls is_valid_position? on the world model" do
      allow(subject).to receive(:gets) { "5" }
      expect(subject.world).to receive(:is_valid_position?).once 
      subject.send(:place_robot)
    end
    
  end
  
end