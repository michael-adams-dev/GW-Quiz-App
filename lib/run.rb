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
    begin
      puts ""
      puts "Finding selection..."
      puts ""
      doc = PicukiDoc.new(PICUKI)
    rescue SocketError
      puts "No internet connection detected"
      puts "Please ensure you are connected to the internet"
      menu = Menu.new
      menu.display_main_menu
    end
      return doc.get_selected_quiz_url(num)
  end

  # This will take the quiz URL returned from get_picuki_doc
  # It then creats a new doc object, search through this doc
  # And return the q&a image URLs
  def self.get_qanda_urls(num)
    begin
      chosen_quiz = RunApp.get_picuki_doc(num)
      puts "Finding quiz data..."
      puts ""
      data = QuizData.new(chosen_quiz)
    rescue SocketError
      puts "No internet connection detected"
      puts "Please ensure you are connected to the internet"
      menu = Menu.new
      menu.display_main_menu
    end
    return data.get_image_urls
  end

  # This method takes the q&a image urls, download them and
  # then converts them to strings
  def self.get_quiz_strings(num)
    urls = RunApp.get_qanda_urls(num)
    QuizInitialiser.download_images(urls)
  end

  # Converts the quiz images to stings then converts these strings 
  # to hashes to be used in the quiz
  # Combines methods from other classes to do this
  def self.convert_quiz_strings_to_hashes(num)
    RunApp.get_quiz_strings(num)
    image_converter = QuizInitialiser.new(PATH_TO_IMAGES)
    image_converter.images_to_strings
    question = PrepQuizItems.new(image_converter.questions)
    question_hash = question.q_string_to_hash
    answer = PrepQuizItems.new(image_converter.answers)
    answer_hash = answer.a_string_to_hash
    return [question_hash, answer_hash]
  end

  # Create a new quiz object and runs the quiz.
  def self.start_quiz(num)
    inputs = RunApp.convert_quiz_strings_to_hashes(num)
    questions = inputs.first
    actual_answers = inputs.last
    Quiz.begin_quiz_menu(questions, actual_answers)
  end
end

RunApp.run_greeting

menu = Menu.new

menu.display_main_menu