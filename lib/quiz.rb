
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
  
  def initialize(questions, actual_answers)
    @id = 
    @date = ''
    @questions = questions
    @actual_answers = actual_answers
    @user_answers = {}
    @score = 0
  end

  def questions_explanation
    puts "Time to do the quiz!."
    puts "Each question will be printed to the screen."
    puts "Once you see it, simply type in your answer and hit the enter/return key."
    puts "Be careful, once you answer a question, you can't change it."
    puts "Ok, let's do it!"
    puts "Ready? (Hit enter/return when you are)"
    gets
  end

  def run_quiz
    @questions.each do |number, question|
      puts ""
      puts "Question #{number} #{question}"
      puts ""
      response = gets.strip
      @user_answers[number] = response
    end
  end

  def answers_explanation
    puts ""
    puts "Time for the answers!"
    puts "Each question will be printed to the screen followed by your answer."
    puts "To show the actual answer, just hit the enter/return key."
    puts "You can then award yourself points if you got some or all of the question correct."
    puts "just type the number of points for the question (0 is fine if you got it wrong)."
    puts "We'll display your overall tally at the end."
    puts "Ready? (Hit enter/return when you are)"
    gets
  end

  def run_results
    @questions.each do |number, question|
      puts ""
      puts "Question #{number} #{question}"
      puts ""
      puts "Your answer: #{@user_answers[number]}"
      puts ""
      gets
      puts "Actual answer: #{@actual_answers[number]}"
      puts ""
      puts "How many points?"
      puts ""
      @score += gets.strip.to_i
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
end

new_quiz = Quiz.new(example_questions, example_answers)

new_quiz.questions_explanation
new_quiz.run_quiz
new_quiz.answers_explanation
new_quiz.run_results
new_quiz.show_score