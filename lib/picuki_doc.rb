require_relative 'greeting'
require_relative 'quiz_helper'
require_relative 'menu'

require 'nokogiri'
require 'open-uri'

class PicukiDoc
  attr_reader :document
  def initialize(url)
    @document = Nokogiri::XML(URI.open(url))
  end

  def get_selected_quiz_url(selection)
    quiz_link_tags = document.css("img:not([alt*='day'])")
    selected_quiz_url = quiz_link_tags[selection].parent['href']
    return selected_quiz_url
  end
end