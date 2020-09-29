require_relative 'greeting'
require_relative 'quiz_helper'

require 'tty-prompt'

class Menu
  include QuizHelper

  def initialize

  end

  def user_selection
    PROMPT.select("What would you like to do?") do |menu|
      menu.choice "Download this week's quiz", 1
      menu.choice "Download last week's quiz", 2
      menu.choice "Choose from quiz database", 3
      menu.choice "Check my past results", 4
      menu.choice "Exit app", 5
    end
  end

  def display_menu
    loop do
      case user_selection
      when 1
        RunApp.get_picuki_doc(1)
      when 2
        RunApp.get_picuki_doc(2)
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