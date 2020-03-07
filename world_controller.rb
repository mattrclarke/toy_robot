class WorldController
  attr_accessor :width, :height, :is_first_render
  def initialize(width, height)
    @height = height
    @width = width
    @is_first_render = true
  end

  def generate_world
    [*0..@height].product([*0..@width]).each_slice(@width + 1).to_a
  end

  def show_world(world_array, player_coordinates)
    world_array.each do |row|
      # Line break for each 'outer' array
      print "\n"
      row.each do |coordinate|
        sleep(0.02) if @is_first_render
        # Display something for each 'inner' array - where the x y coords sit
        render_coordinate(coordinate, player_coordinates)
      end
    end

  end

  def render_coordinate(coordinate, player_coordinates)
    if coordinate == player_coordinates
      print "0--0".green
    else
      print "~~~~".yellow
    end
  end
end
