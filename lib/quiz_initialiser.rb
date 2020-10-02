require_relative 'quiz_helper'
require_relative 'greeting'

require 'down'
require 'rtesseract'

include QuizHelper

class QuizInitialiser
  
  include QuizHelper

  def initilize

  end

  def self.download_images(arr)
    puts "Downloading quiz data..."
    puts ""
    questions, answers = arr[0], arr[1]
    Down.download(questions, destination: PATH_TO_IMAGES[0])
    Down.download(answers, destination: PATH_TO_IMAGES[1])
  end

  def self.images_to_strings(arr)
    puts "Preparing quiz..."
    puts ""
    fact = Greeting.new
    fact.random_fact
    questions_string = RTesseract.new(arr[0]).to_s
    answers_string = RTesseract.new(arr[1]).to_s
    return [questions_string, answers_string]
  end
end