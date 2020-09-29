require_relative 'quiz_helper'

require 'down'
require 'rtesseract'

include QuizHelper

files = ["https://scontent-yyz1-1.cdninstagram.com/v/t51.2885-15/e35/p1080x1080/120204134_350094963008228_8958777070033343188_n.jpg?_nc_ht=scontent-yyz1-1.cdninstagram.com&_nc_cat=108&_nc_ohc=Ru7IBp3GF4EAX9hHAiX&_nc_tp=19&oh=31cb57c5493213819b558c27c4172f00&oe=5F9C477A", "https://scontent-lga3-1.cdninstagram.com/v/t51.2885-15/e35/p1080x1080/120094932_1189728791399925_8954531587350649576_n.jpg?_nc_ht=scontent-lga3-1.cdninstagram.com&_nc_cat=109&_nc_ohc=amjg4e28egoAX-Zv0Uj&_nc_tp=19&oh=08226c64b8a65a804f170049fb9cf41a&oe=5F9BBB23"]

# Down.download(file, destination: PATH_TO_QUESTIONS)

# tesseract_img = RTesseract.new(PATH_TO_QUESTIONS)

# puts tesseract_img.to_s

class QuizInitialiser
  
  include QuizHelper

  def initilize

  end

  def self.download_images(arr)
    puts "Downloading quiz data..."
    questions, answers = arr[0], arr[1]
    Down.download(questions, destination: PATH_TO_IMAGES[0])
    Down.download(answers, destination: PATH_TO_IMAGES[1])
  end

  def self.images_to_strings(arr)
    puts ""
    questions_string = RTesseract.new(arr[0]).to_s
    answers_string = RTesseract.new(arr[1]).to_s
    puts questions_string
    # puts answers_string
  end
end

# QuizInitialiser.download_images(files)

QuizInitialiser.images_to_strings(PATH_TO_IMAGES)