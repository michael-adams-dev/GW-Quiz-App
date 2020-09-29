require_relative 'greeting'
require_relative 'quiz_helper'
require_relative 'menu'
require_relative 'picuki_doc'

require 'tty-prompt'
require 'open-uri'
require 'nokogiri'

class RunApp

  def initialize

  end

  def run_greeting
    start = Greeting.new
    puts start.greet
    puts start.random_fact
  end

  def get_picuki_doc
    return PicukiDoc.new("https://www.picuki.com/profile/goodweekendquiz")
  end
end

run = RunApp.new
run.run_greeting

menu = Menu.new

menu.display_menu