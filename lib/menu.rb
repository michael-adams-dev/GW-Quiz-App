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
  def main_menu_selection
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
  def display_main_menu
    loop do
      case main_menu_selection
      when 1
        inputs = RunApp.convert_quiz_strings_to_hashes(1)
        Quiz.begin_quiz_menu(inputs)
      when 2
        inputs = RunApp.convert_quiz_strings_to_hashes(2)
        Quiz.begin_quiz_menu(inputs)
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