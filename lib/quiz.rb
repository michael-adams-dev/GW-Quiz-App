
example_questions = {
  1 => "Palmerston was the former name of which Australian city?",
  2 => "What is a cartouche, used in French cooking, made from?",
  3 => "New York City’s Queensboro Bridge crosses which river?",
  4 => "Operation Overlord was the codename for which battle during World War II?",
  5 => "Australia’s Indigenous NIFA awards celebrate excellence in what industry?"
}

example_answers = {
  1 => "Darwin",
  2 => "Paper (parchment or grease-proof; used to cover the surface of a stock, stew, sauce or
  soup to reduce evaporation).",
  3 => "East River.",
  4 => "Battle (invasion) of Normandy (launched on June 6, 1944, D-Day).",
  5 => "Fashion."
}


class Quiz
  
  attr_reader :questions, :actual_answers
  attr_accessor :id, :date, :user_answers, :score
  
  def initialize(questions_and_answers)
    @id = 
    @date = ''
    @questions = questions_and_answers.first
    @actual_answers = questions_and_answers.last
    @user_answers = {}
    @score = 0
  end

  def questions_explanation
    puts "Time to do the quiz!."
    puts ""
    puts "Each question will be printed to the screen."
    puts "Once you see it, simply type in your answer and hit the enter/return key."
    puts "Be careful, once you answer a question, you can't change it."
    puts ""
    puts "Ok, let's go! (Hit enter/return when you're ready)"
    gets
  end

  def display_questions
    @questions.each do |number, question|
      puts ""
      puts "Question #{number}: #{question}"
      print "> "
      response = gets.strip
      @user_answers[number] = response
      puts ""
    end
  end

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

  def display_results
    @questions.each do |number, question|
      puts ""
      puts "Question #{number}: #{question}"
      puts ""
      puts "Your answer: #{@user_answers[number]}"
      gets
      puts "Actual answer: #{@actual_answers[number]}"
      puts ""
      puts "How many points?"
      print "> "
      @score += gets.strip.to_f
      puts ""
    end
  end

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
    when 15..16
    end
    puts "Nice Job!"
  end

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

  def self.begin_quiz_menu(quiz_inputs)
    case Quiz.begin_quiz
    when 1
      system("clear")
      new_quiz = Quiz.new(quiz_inputs)
      new_quiz.run_quiz
    when 2
      system("clear")
    end
  end

  def run_quiz
    self.questions_explanation
    self.display_questions
    self.answers_explanation
    self.display_results
    self.show_score
  end
end

# new_quiz = Quiz.new([example_questions, example_answers])

# new_quiz.questions_explanation
# new_quiz.display_questions
# new_quiz.answers_explanation
# new_quiz.display_results
# new_quiz.show_score