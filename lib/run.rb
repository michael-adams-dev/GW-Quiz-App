require_relative 'greeting'
require_relative 'quiz_helper'
require_relative 'menu'
require_relative 'picuki_doc'

require 'tty-prompt'
require 'open-uri'
require 'nokogiri'

class RunApp

  include QuizHelper

  def initialize

  end

  def self.run_greeting
    start = Greeting.new
    puts start.greet
    puts start.random_fact
  end

  def self.get_picuki_doc(num)
    puts "Finding quiz"
    doc = PicukiDoc.new(PICUKI)
    puts doc.get_selected_quiz_url(num)
    puts ""
  end
end

RunApp.run_greeting

menu = Menu.new

menu.display_menu