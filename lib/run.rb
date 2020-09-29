require_relative 'greeting'
require_relative 'quiz_helper'
require_relative 'menu'
require_relative 'picuki_doc'
require_relative 'quiz_data'

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
    puts "Finding selection"
    puts ""
    doc = PicukiDoc.new(PICUKI)
    return doc.get_selected_quiz_url(num)
  end

  def self.get_qanda_urls(num)
    chosen_quiz = RunApp.get_picuki_doc(num)
    puts "Finding quiz data"
    data = QuizData.new(chosen_quiz)
    puts data.get_image_urls
  end
end

RunApp.run_greeting

menu = Menu.new

menu.display_menu