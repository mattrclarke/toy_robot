# toy_robot

# Dependencies
`ruby > 2.5.2`

# Installation
run `bundle install`

# Overview
The goal is to place a 'robot' agent on a specified grid.
Robot should error if placed outside the gird, be able to move forward, turn left and right, and report on it's current position.

I had originally written navigation code on the robot, as it seemed like the robot
should know about its position and location data.
By breaking navigation/position data out into a movement controller class I was able to create
a reusable class that could potentially be used for any other agents that require navigation.

# Running
run `ruby toy_robot.rb` from the toy_robot directory

# Testing
Tests written in `rspec 3.9.0`
type `rspec` to run all tests or `rspec /path_to_spec/spec_file.rb` for individual tests

