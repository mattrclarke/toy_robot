# header H1
Dependencies
# header H1
ruby > 2.5.2

# header H1
Installation

run bundle install

overview
I had originally written navigation code on the robot, as it seemed like the robot
should know about its position and location data, but by breaking it out into a movement
controller class we now have a reusable component for any other agents that require navigation
without having to re-write movement code and conditions.
ProgramController 

running

run `ruby toy_robot.rb` from the toy_robot directory

testing
Tests are written using rspec 3.9.0, 
type rspec to run all tests or rspec <path_to_spec/spec_file.rb> for individual tests

