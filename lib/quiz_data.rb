require 'nokogiri'
require 'open-uri'

class QuizData
  
  attr_reader :quiz_page


  def initialize(url)
    @quiz_page = Nokogiri::HTML.parse(URI.open(url))
  end

  def get_image_urls
    image_containers = quiz_page.css("img[alt='goodweekendquiz']")

    questions_image_url = image_containers[0]['src']

    answers_image_url = image_containers[3]['src']

    puts [questions_image_url, answers_image_url]
  end
end