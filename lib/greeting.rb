require_relative 'quiz_helper'
require_relative 'picuki_doc'

class Greeting
  include QuizHelper
  
  attr_reader :facts
  
  def initialize
    @facts = FACTS
  end

  def self.greet
    puts ""
    puts "Welcome to the Good Weekend Quiz App!"
    puts ""
    puts "Here you can download the Good Weekend quiz from the last two weeks."
    puts "Alternatively, you can select a prior quiz from the quiz database."
  end

  # Method will get a random number in a range equal to the length
  # of the fun facts array. It them uses this number as an index to
  # get a random fact from the array and print to screen.
  def random_fact
    fact_num = rand(0..1)
    puts "Did you know? #{FACTS[fact_num]}"
    puts ""
    puts "Your quiz will be ready in a moment."
    puts ""
  end
end