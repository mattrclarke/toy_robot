require_relative "../../lib/world"
require_relative "../../lib/movement_controller"
RSpec.describe MovementController do

  subject { MovementController.new 0, 0, 0, @world }
  
  before do 
    random_size = rand(4..15)
    @world = World.new(random_size, random_size)
    subject.coords[:x] = (2..(subject.world.width - 2)).to_a.sample
    subject.coords[:y] = (2..(subject.world.height - 2)).to_a.sample
  end
  
  describe "#left" do 
    context "when the movement controller's direction is at the end of it's compass" do 
      it "sets it's direction to it's last available direction" do 
        subject.left
        expect(subject.direction).to eq(subject.compass.length - 1)
      end
    end
    context "when the movement controller's direction is NOT at the end of it's compass" do 
      it "updates the direction of the movement controller by - 1" do 
        subject.direction = subject.compass.length - 1
        current_direction = subject.direction
        subject.left
        expect(subject.direction).to eq(current_direction - 1)
      end
    end
  end
  
  describe "#right" do 
    context "when the movement controller's direction is at the beginning of it's compass" do 
      it "sets it's direction to it's first available direction" do 
        subject.direction = subject.compass.length - 1
        subject.right
        expect(subject.direction).to eq(0)
      end
    end
    context "when the movement controller's direction is NOT at the end of it's compass" do 
      it "updates the movement controller's direction of the movement controller by - 1" do 
        current_direction = subject.direction
        subject.right
        expect(subject.direction).to eq( current_direction + 1 )
      end
    end
  end
  
  describe "#attempt_move" do 
    it "calls new position" do
      expect(subject).to receive(:new_position).once 
      subject.attempt_move
    end
  end
  
  describe "#report" do
    it "displays the movement controllers direction and position" do
      subject.coords[:x] = 2
      subject.coords[:y] = 4
      expect(subject.report).to eq("North [4, 2]")
    end
  end
  
  describe "#coordinates_exist?" do
    it "checks the world to see if the coordinates are present" do
      expect(subject.world).to receive(:is_valid_position?).once 
      subject.coordinates_exist?(subject.coords[:y], subject.coords[:x])
    end
  end
  
  describe "#facing" do
    it "returns the facing direction" do
      subject.direction = 0
      expect(subject.send(:facing)).to eq("north")
    end
  end  
  
  describe "#new_position" do
    context "when the resulting movement is valid" do
      context "when facing north" do 
        it "updates the y axis by + 1" do
          subject.direction = 0
          y_axis = subject.coords[:y]
          subject.send(:new_position, subject.coords)
          expect(subject.coords[:y]).to eq(y_axis + 1)
        end
      end
      
      context "when facing east" do 
        it "updates the x axis by + 1" do
          subject.direction = 1
          x_axis = subject.coords[:x]
          subject.send(:new_position, subject.coords)
          expect(subject.coords[:x]).to eq(x_axis + 1)
        end
      end
      
      context "when facing south" do 
        it "updates the y axis by - 1" do
          subject.direction = 2
          y_axis = subject.coords[:y]
          subject.send(:new_position, subject.coords)
          expect(subject.coords[:y]).to eq(y_axis - 1)
        end
      end
      
      context "when facing west" do 
        it "updates the x axis by - 1" do
          subject.direction = 3
          x_axis = subject.coords[:x]
          subject.send(:new_position, subject.coords)
          expect(subject.coords[:x]).to eq(x_axis - 1)
        end
      end
      
    end
    context "when the new position is NOT valid" do
      it "raises an error" do 
        subject.coords[:y] = subject.world.height
        expect { subject.attempt_move }.to raise_error(MovementController::MovementError)
      end
    end
  end
  
end