require_relative 'greeting'
require_relative 'quiz_helper'
require_relative 'prepare_quiz'

require 'tty-prompt'

class Menu
  include QuizHelper

  def initialize

  end

  # User selection method creates the main menu for the user
  # and displays it on the screen to get their selection
  def user_selection
    puts ""
    PROMPT.select("What would you like to do?") do |menu|
      menu.choice "Download this week's quiz", 1
      menu.choice "Download last week's quiz", 2
      menu.choice "Choose from quiz database", 3
      menu.choice "Check my past results", 4
      menu.choice "Exit app", 5
    end
  end

  # Display menu method creates a loop to check the user's selection
  # from the main menu and then run methods depending on the selection
  def display_menu
    loop do
      case user_selection
      when 1
        q_and_a_strings = RunApp.get_quiz_strings(1)
        question = PrepQuizItems.new(q_and_a_strings[0])
        question_hash = question.q_string_to_hash
        answer = PrepQuizItems.new(q_and_a_strings[1])
        answer_hash = answer.a_string_to_hash
      when 2
        q_and_a_strings = RunApp.get_quiz_strings(2)
        question = PrepQuizItems.new(q_and_a_strings[0])
        question_hash = question.q_string_to_hash
        answer = PrepQuizItems.new(q_and_a_strings[1])
        answer_hash = answer.a_string_to_hash
      when 3
        puts "You want to see the quiz db"
        puts ""
      when 4
        puts "You want to check your scores"
        puts ""
      when 5
        exit
      end
    end
  end
end