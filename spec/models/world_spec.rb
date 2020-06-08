require_relative "../../lib/world"
require 'byebug'
RSpec.describe World do

  subject { World.new(3, 5) }
  
  before do 
    Robot.any_instance.stub(:gets).and_return("5")
  end
  
  describe "#generate world" do 
    it "generates a world with a height of a given size" do 
      expect(subject.width).to eq(3)
      expect(subject.height).to eq(5)
    end
  end
  
  describe "#is_valid_position" do 
    context "when given coordinates" do
      context "and the coordinates are within the world dimensions" do 
        it "returns true" do
          expect(subject.is_valid_position?(subject.width, subject.height)).to be_truthy
        end
      end
      context "and the coordinates are NOT within the worlds dimensions" do 
        it "returns false" do
          expect(subject.is_valid_position?(subject.width + 1, subject.height)).to be_falsey
        end
      end
    end
  end
end
