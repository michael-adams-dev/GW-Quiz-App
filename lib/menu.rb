require_relative 'greeting'
require_relative 'quiz_helper'
require_relative 'prepare_quiz'
require_relative 'quiz_db'

require 'tty-prompt'

class Menu
  include QuizHelper

  def initialize
    @quiz_db = QuizDB.new
  end

  # User selection method creates the main menu for the user
  # and displays it on the screen to get their selection
  def main_menu_selection
    puts ""
    PROMPT.select("What would you like to do?") do |menu|
      menu.choice "Download this week's quiz", 1
      menu.choice "Download last week's quiz", 2
      menu.choice "Exit app", 3
    end
  end

  # Display menu method creates a loop to check the user's selection
  # from the main menu and then run methods depending on the selection
  def display_main_menu
    loop do
      case main_menu_selection
      when 1
        RunApp.start_quiz(1)
      when 2
        RunApp.start_quiz(2)
      when 3
        exit
      end
    end
  end
end