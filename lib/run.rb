require_relative 'greeting'
require_relative 'quiz_helper'
require_relative 'menu'
require_relative 'picuki_doc'
require_relative 'quiz_data'
require_relative 'quiz_initialiser'
require_relative 'quiz'
require_relative 'prepare_quiz'

require 'tty-prompt'
require 'open-uri'
require 'nokogiri'

class RunApp
  include QuizHelper

  def initialize

  end

  # Creates a new greeting object then prints the greeting
  # and a random fact at the start of the app
  def self.run_greeting
    puts Greeting.greet
  end

  # This will create a new Picuki doc object 
  # based off the user's seletion and get the quiz url
  def self.get_picuki_doc(num)
    puts ""
    puts "Finding selection..."
    puts ""
    doc = PicukiDoc.new(PICUKI)
    return doc.get_selected_quiz_url(num)
  end

  # This will take the quiz URL returned from get_picuki_doc
  # It then creats a new doc object, search through this doc
  # And return the q&a image URLs
  def self.get_qanda_urls(num)
    chosen_quiz = RunApp.get_picuki_doc(num)
    puts "Finding quiz data..."
    puts ""
    data = QuizData.new(chosen_quiz)
    return data.get_image_urls
  end

  # This method takes the q&a image urls, download them and
  # then converts them to strings
  def self.get_quiz_strings(num)
    urls = RunApp.get_qanda_urls(num)
    QuizInitialiser.download_images(urls)
    QuizInitialiser.images_to_strings(PATH_TO_IMAGES)
  end

  def self.convert_quiz_strings_to_hashes(num)
    q_and_a_strings = RunApp.get_quiz_strings(num)
    question = PrepQuizItems.new(q_and_a_strings[0])
    question_hash = question.q_string_to_hash
    answer = PrepQuizItems.new(q_and_a_strings[1])
    answer_hash = answer.a_string_to_hash
    return [question_hash, answer_hash]
  end
end

RunApp.run_greeting

menu = Menu.new

menu.display_main_menu