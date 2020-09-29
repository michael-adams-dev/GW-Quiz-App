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
        doc = PicukiDoc.new
        puts doc.get_selected_quiz_url(1)
        puts ""
      when 2
        doc = PicukiDoc.new
        puts doc.get_selected_quiz_url(2)
        puts ""
      when 3
        puts "You want to see the quiz db"
        puts ""
      when 4
        puts "You want to check your scores"
        puts ""
      when 5
        quit
      end
    end
  end
end