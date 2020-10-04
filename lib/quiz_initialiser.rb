require_relative 'quiz_helper'
require_relative 'greeting'

require 'down'
require 'rtesseract'

class QuizInitialiser
  
  include QuizHelper

  attr_accessor :questions, :answers
  attr_reader :questions_image, :answers_image

  def initialize(image_paths)
    @questions_image = image_paths[0]
    @answers_image = image_paths[1]
    @questions = ""
    @answers = ""
  end

  # Used to download question and answer images after selection is made
  # and images have been found
  def self.download_images(arr)
    puts "Downloading quiz data..."
    puts ""
    questions, answers = arr[0], arr[1]
    Down.download(questions, destination: PATH_TO_IMAGES[0])
    Down.download(answers, destination: PATH_TO_IMAGES[1])
  end

  # Converts the images to strings and stores strings in instance variables
  def images_to_strings
    puts "Preparing quiz..."
    puts ""
    fact = Greeting.new
    fact.random_fact
    @questions = RTesseract.new(@questions_image).to_s
    @answers = RTesseract.new(@answers_image).to_s
  end
end