class World
  attr_accessor :width, :height  
  def initialize(width, height)
    @width = width 
    @height = height
    generate_world(@width, @height)
  end

  def generate_world(height, width)
    [*0..height].product([*0..width]).each_slice(@width + 1).to_a
  end
  
  def is_valid_position? (y, x)
    y.between?(0, @width) && x.between?(0, @height)
  end
  
end
