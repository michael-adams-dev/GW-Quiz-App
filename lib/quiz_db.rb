require 'json'
require_relative 'quiz_helper'
require_relative 'quiz'

class QuizDB
  include QuizHelper

  attr_accessor :quizzes

  def initialize
    @quizzes = read_quizzes
  end

  def read_quizzes
    data = File.read(QUIZ_DATABASE)
    JSON.parse(data).map do |quiz|
      Quiz.new(
        quiz['questions'],
        quiz['actual_answers'],
        quiz['id'],
        quiz['date'],
        quiz['user_answers'],
        quiz['score']
      )
    end
  end

  def write_quizzes
    data = @quizzes.map do |quiz|
      {
        questions: quiz.questions,
        actual_answers: quiz.actual_answers,
        id: quiz.id,
        date: quiz.date,
        user_answers: quiz.user_answers,
        score: quiz.score
      }
    end
    File.write(QUIZ_DATABASE, JSON.pretty_generate(data))
  end
end