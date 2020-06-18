require_relative "../../models/world"
require_relative "../../models/movement_controller"
require_relative "../../models/robot"
require "byebug"
RSpec.describe MovementController do

  subject { MovementController.new 0, 0, 0, @world }
  
  before do 
    random_size = rand(4..15)
    @world = World.new(random_size, random_size)
  end
  
  describe "#left" do 
    context "when the movement controller's direction is at the beginning of it's compass" do 
      it "sets it's direction to it's last available direction" do 
        subject.left
        expect(subject.direction).to eq(MovementController::COMPASS.length - 1)
      end
    end
    context "when the movement controller's direction is NOT at the beginning of it's compass" do 
      it "updates the direction of the movement controller by - 1" do 
        subject.direction = MovementController::COMPASS.length - 1
        current_direction = subject.direction
        subject.left
        expect(subject.direction).to eq(current_direction - 1)
      end
    end
  end
  
  describe "#right" do 
    context "when the movement controller's direction is at the end of it's compass" do 
      it "sets it's direction to it's first available direction" do
        subject.direction = MovementController::COMPASS.length - 1
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
      subject { MovementController.new y_coords, x_coords, direction, world }
      let(:world) { World.new(5, 5) }
      let(:y_coords) { 0 }
      let(:x_coords) { 0 }
      
      context "when facing north" do
        let(:direction) { 0 }  
        it "updates the y axis by + 1" do
          expect{ subject.attempt_move }.to change{ subject.coords[:y] }.from(0).to(1)
        end
      end
      
      context "when facing east" do 
        let(:direction) { 1 }
        it "updates the x axis by + 1" do
          expect{ subject.attempt_move }.to change{ subject.coords[:x]}.from(0).to(1)
        end
      end
      
      context "when facing south" do 
        let(:direction) { 2 }
        let(:y_coords) { 1 }
        it "updates the y axis by - 1" do
          expect{ subject.attempt_move }.to change{ subject.coords[:y] }.from(1).to(0)
        end
      end
      
      context "when facing west" do
        let(:direction) { 3 }
        let(:x_coords) { 1 }
        it "updates the x axis by - 1" do
          expect{ subject.attempt_move }.to change{ subject.coords[:x] }.from(1).to(0)
        end
      end
      
    end
    context "when the new position is NOT valid" do
      subject { MovementController.new y_coords, x_coords, direction, world }
      let(:direction) { 1 }
      let(:y_coords) { 0 }
      let(:x_coords) { 4 }
      
      it "raises an error" do
        expect { subject.attempt_move }.to raise_error(StandardError)
      end
    end
  end
  
end