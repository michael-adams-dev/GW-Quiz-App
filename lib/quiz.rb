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
    puts "If you can't think of an anser right away, you can skip the question and return to it at the end"
    puts ""
    puts "Ok, let's go! (Hit enter/return when you're ready)"
    gets
  end

  def option_to_skip
    PROMPT.select("Answer now or skip?  You can come back to it if you skip") do |menu|
      menu.choice "Answer now", 1
      menu.choice "Skip for now", 2
    end
  end
  
  def option_to_skip_case(num)
    case option_to_skip
    when 1
      print "> "
      response = gets.strip
      @user_answers[num] = response
    when 2
      @user_answers[num] = 'skipped'
    end
  end

  def display_questions
    @questions.each do |number, question|
      puts ""
      puts "Question #{number}: #{question}"
      puts ""
      option_to_skip_case(number)
      puts ""
    end
  end

  def skipped_questions_explanation
    puts ""
    puts "Now you can answer the questions that you skipped."
    puts "If you can't think of an answer, just hit enter/return to pass."
    puts "Once you've answered or passed these questions we'll go over the answers."
    puts ""
  end

  def skipped_questions
    @questions.each do |number, question|
      if @user_answers[number] == 'skipped'
        puts "Question #{number}: #{question}"
        print "> "
        response = gets.strip
        @user_answers[number] = response
      end
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
    self.skipped_questions_explanation
    self.skipped_questions
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