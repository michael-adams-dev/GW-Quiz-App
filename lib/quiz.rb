require_relative 'quiz_helper'

class PointsTooHigh < StandardError
end

class WrongCharacters < StandardError
end

class Quiz
  
  include QuizHelper

  attr_reader :questions, :actual_answers
  attr_accessor :id, :date, :user_answers, :score
  
  def initialize(questions, actual_answers, id='', date='N/A', user_answers={}, score='-')
    @id = id
    @date = date
    @questions = questions
    @actual_answers = actual_answers
    @user_answers = user_answers
    @score = score
  end

  # Method below will be printed to give the user instructions on
  # how to do the quiz
  def questions_explanation
    puts "Time to do the quiz!."
    puts ""
    puts "Each question will be printed to the screen."
    puts "Once you see it, simply type in your answer and hit the enter/return key."
    puts "If you can't think of an answer right away, you can skip the question and return to it at the end."
    puts ""
    puts "Ok, let's go! (Hit enter/return when you're ready)"
    gets
  end

  # The method below provides the uer with the option to skip the 
  # question and return to it later
  def option_to_skip
    PROMPT.select("Answer now or skip?  You can come back to it if you skip") do |menu|
      menu.choice "Answer now", 1
      menu.choice "Skip for now", 2
    end
  end
  
  # The method below controls what happens when the user either skips
  # or answers a question
  def option_to_skip_case(num)
    case option_to_skip
    when 1
      print "> "
      response = gets.strip
      @user_answers[num] = response
    when 2
      @user_answers[num] = 'no answer'
    end
  end

  # The method below loops through all the questions and displays
  # the question number and question
  def display_questions
    @questions.each do |number, question|
      puts ""
      puts "Question #{number}: #{question}"
      puts ""
      option_to_skip_case(number)
      puts ""
    end
  end

  # The method below will print the message to the screen to explain that
  # the user can now answer questions that were skipped.
  def skipped_questions_explanation
    puts ""
    puts "Now you can answer the questions that you skipped."
    puts "If you can't think of an answer, just hit enter/return to pass."
    puts "Once you've answered or passed these questions we'll go over the answers."
    puts ""
  end

  # The method below loops through the questions and checks if they were skipped
  # If the question was, the question is printed to screen and the user 
  #  can answer it this time
  def skipped_questions
    @questions.each do |number, question|
      if @user_answers[number] == 'no answer'
        puts "Question #{number}: #{question}"
        print "> "
        response = gets.strip
        @user_answers[number] = response
      end
    end
  end

  # Method to give the user info on how answers work
  def answers_explanation
    system("clear")
    puts "Time for the answers!"
    puts ""
    puts "Each question will be printed to the screen followed by your answer."
    puts "To show the actual answer, just hit the enter/return key."
    puts "You can then award yourself points if you got some or all of the question correct."
    puts "Just type the number of points for the question (0 is fine if you got it wrong) and hit enter/return."
    puts "We'll display your overall tally at the end."
    puts ""
    puts "Please note: if you want to give yourself half a point, please use decimals instead of fractions"
    puts "E.g. enter 0.5 instead of 1/2"
    puts ""
    puts "Ready? (Hit enter/return when you are)"
    gets
  end

  # The method below will display each question, each user answer, and each 
  # actual answer. 
  def display_results
    @score = 0
    @questions.each do |number, question|
      puts ""
      puts "Question #{number}: #{question}"
      puts ""
      puts "Your answer: #{@user_answers[number]}"
      gets
      puts "Actual answer: #{@actual_answers[number]}"
      puts ""
      score_rescue
      puts ""
    end
  end

  # The method below is run during the display results method and allows
  # the user to add to their score
  # it can handle errors for invalid inputs like factions or scores greater than 1 per question.
  def score_rescue
    begin
      puts "How many points?"
      print "> "
      points = gets.strip
      raise WrongCharacters if points.include?('/')
      raise PointsTooHigh if points.to_f > 1
    rescue WrongCharacters
      puts "Please use decimals instead of fractions"
      puts ''
      retry
    rescue PointsTooHigh
      puts "Each question is worth a maximum of one point"
      puts ''
      retry
    end
    @score += points.to_f
  end

  # The method below shows the user their score and displays a message
  # depending on what their score was
  def show_score
    puts ""
    puts "Your total is: #{@score}/25"
    puts ""
    case @score
    when 0..5
      puts "Shameful"
    when 6..10
      puts "I wouldn't go bragging about this"
    when 11..12
      puts "Might need some more help next time!"
    when 13..14
      puts "Not too bad!"
    when 15..17
      puts "Nice work!"
    when 18..19
      puts "Great score!"
    when 20..21
      puts "You cracked 20, excellent effort"
    when 22..24
      puts "That was out of this world!"
    when 25
      puts "Me oh my, perfect score!"
    end
  end

  # The method below allows the user to decide if they want to begin the quiz once downloaded
  def self.begin_quiz
    system("clear")
    puts ""
    puts "Your quiz is ready!"
    puts ""
    PROMPT.select("Would you like to start the quiz?") do |menu|
      menu.choice "Yeah, let's go", 1
      menu.choice "I've changed my mind, take me back", 2
    end
  end

  # The method below will either run the quiz or take the user back to the
  # main menu depending on their selection in begin_quiz
  def self.begin_quiz_menu(questions, actual_answers)
    case Quiz.begin_quiz
    when 1
      system("clear")
      new_quiz = Quiz.new(questions, actual_answers)
      new_quiz.run_quiz
    when 2
      system("clear")
    end
  end

  # The method below combines previous methods to run the quiz.
  def run_quiz
    self.questions_explanation
    self.display_questions
    self.skipped_questions_explanation
    self.skipped_questions
    self.answers_explanation
    self.display_results
    self.show_score
  end
end