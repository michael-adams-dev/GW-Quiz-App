require_relative 'quiz_helper'
require_relative 'picuki_doc'

class Greeting
  include QuizHelper
  
  attr_reader :facts
  
  def initialize
    @facts = FACTS
  end

  def greet
    puts ""
    puts "Welcome to the Good Weekend Quiz App!"
    puts "Here you can download the Good Weekend quiz from the last two weeks."
    puts "Or you can select a prior quiz from the quiz database."
    puts ""
  end

  def random_fact
    fact_num = rand(0..1)
    puts "Did you know? #{FACTS[fact_num]}"
    puts ""
  end
end