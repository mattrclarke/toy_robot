# toy_robot
run ruby program_controller.rb to start

# header H1
Dependencies
# header H1
ruby > 2.5.2

overview
I had originally written navigation code on the robot, as it seemed like the robot
should know about its position and location data, but by breaking it out into a movement
controller class we now have a reusable component for any other agents that require navigation
without having to re-write movement code and conditions

running

testing
Tests are written using rspec 3.9.0, 
to run, type rspec

