require 'json'
require_relative 'quiz_helper'

class QuizDB
include QuizHelper

  def initialize
    @quizzes = read_quizzes
  end

  def read_quizzes
    data = File.read(QUIZ_DATABASE)
    JSON.parse(data).map do |quiz|
      Quiz.new(
        quiz
      )
    end
  end
end