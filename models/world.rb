class World
  attr_accessor :width, :height
  
  def initialize(width, height)
    @width = width 
    @height = height
  end
  
  def is_valid_position?(y, x)
    y.between?(0, @width - 1) && x.between?(0, @height - 1)
  end
  
  def generate_world
    [*0..@height - 1].product([*0..@width - 1]).each_slice(width).to_a
  end
  
  private

  
end