class World
  attr_accessor :width, :height  
  def initialize(width, height)
    @width = width 
    @height = height
    generate_world(@width, @height)
  end
  
  def is_valid_position? (y, x)
    y.between?(0, @width - 1) && x.between?(0, @height - 1)
  end
  
  private
  def generate_world(height, width)
    [*0..height - 1].product([*0..width - 1]).each_slice(width).to_a
  end
  
end