require_relative "../../models/world"
require_relative "../../models/robot"
RSpec.describe Robot do

  subject { Robot.new @world, 5, 5 }
  
  before do
    @world = World.new(10, 10)
  end
  
  describe "#execute" do
    context "when the robot is given valid input" do
      context "when the input is move" do
        it "calls move on the robot" do
          expect(subject).to receive(:move).once
          subject.execute("move")
        end
      end
      
      context "when the input is left" do
        it "calls left on the robot" do
  
          expect(subject).to receive(:left).once
          subject.execute("left")
        end
      end
      
      context "when the input is right" do
        it "calls right on the robot" do
  
          expect(subject).to receive(:right).once
          subject.execute("right")
        end
      end
      
      context "when the input is report" do
        it "calls report on the robot" do
  
          expect(subject).to receive(:report).once
          subject.execute("report")
        end
      end
      
      context "when the input is get_map" do
        it "calls get_map on the robot" do
  
          expect(subject).to receive(:get_map).once
          subject.execute("get_map")
        end
      end      
    end
    
    context "when the input is not valid" do 
      it "raises an error" do
        expect { subject.execute("foobar") }.to raise_error(ArgumentError)
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
    it "raises an error if the position is not on the table" do
      expect { subject.place_robot(30,30) }.to raise_error(ArgumentError)
    end
  
    it "calls is_valid_position? on the world model" do
      expect(subject.world).to receive(:is_valid_position?).once 
      subject.place_robot(5, 5)
    end
  
  end
  
end