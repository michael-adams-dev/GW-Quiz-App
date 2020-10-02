class String
  def numeric?
    Float(self) != nil rescue false
  end
end

class PrepQuizItems < String
  attr_accessor :data
  
  def initialize(data)
    @data = data
  end

  # Removes all of the unnecessary characters from the string and splits
  # into an array of separate strings
  def remove_characters
    @data = @data.gsub(/\n/, ' ').gsub(/\f/, ' ').gsub(/\s+/, ' ')
    @data = @data.split(' ')
  end

  # The last step is to turn the question or answer array into a hash
  # The method creates a blank has and maps the array integers to the key
  # and the array string (Q or A) to the value and returns the hash
  def arr_to_hash
    questions_hash = {}
    @data.each do |q_or_a|
      questions_hash[q_or_a.first] = q_or_a.last
    end
    @data = questions_hash
  end

  # We need to segment the questions array into each distinct question
  # This will be done by creating an array of strings for each question
  # called single_question, sub strings are added until the end of q
  # this array is then added to a larger array to hold them all
  # The method will start a new array for each question once it finds a
  # string with length 2 or 3 that starts with a number and ends with a 
  # full stop, e.g. 2. or 16. 
  def question_split
    arr_of_strings = []
    single_question = []
    @data.each do |str|
      if str.length == 3 || str.length == 2
        if str[0].numeric? && str[-1] == '.'
          arr_of_strings << single_question
          single_question = []
          single_question << str
        else
          single_question << str
        end
      else
        single_question << str
      end
    end
    arr_of_strings << single_question
    @data = arr_of_strings
  end

  # Now we need to join the sub strings that form each question
  # so loop through the array to get each array of sub strings
  # then join the sub stings together with a space
  def question_join
    strings_joined = @data.map do |question|
      question.join(' ')
    end
    @data = strings_joined
  end

  # Now we need to sort the questions in numeric order so the question
  # and answer orders match. Start by splitting each question into two
  # so we have a string with the question number and one with the question
  # Then remove the first array which has the quiz intro but no question.
  # finally, convert numbers to integers to be sorted and string whitespace
  # from the questions.
  def sort_questions
    q_arr = @data.map do |question|
      question.split('.', 2)
    end
    q_arr.shift
    q_num_to_i = q_arr.map do |question|
      question = [question[0].to_i, question[1].strip]
    end
    @data = q_num_to_i.sort
  end

  # This method combines the previous question manipulation methods from
  # to finish
  def q_string_to_hash
    self.remove_characters
    self.question_split
    self.question_join
    self.sort_questions
    self.arr_to_hash
    return self.data
  end

  # Answer strings will sometimes be formatted with a full stop after
  # the answer number. This needs to be removed for answers to be separated
  def correct_formatting
    formatted = [] 
    @data.each_with_index do |str, index|
      if str.end_with?('.') && @data[index - 1].end_with?('.')
        formatted << str.chop
      else
        formatted << str
      end
    end
    @data = formatted
  end

  # Now we need to segment the array into each distinct answer.
  # Sub strings will be added to a new array (single_answer) until
  # the substring ends with a full stop, which indicates that is
  # the end of the answer.
  # Single_answer is then added to arr_of_strings, then cleared 
  # So it can start gathering the sub strings of the next answer.
  def answer_split
    arr_of_strings = []
    single_answer = []
    @data.each do |str|
      if str[-1] == '.'
        single_answer << str
        arr_of_strings << single_answer
        single_answer = []
      else
        single_answer << str
      end
    end
    arr_of_strings << single_answer
    @data = arr_of_strings
  end

  # Now we need to join the sub strings that form each answer
  # so loop through the array to get each array of sub strings
  # then join the sub stings together with a space
  # finally, remove the quiz answers string from the start of 
  # answer 1
  def answer_join
    strings_joined = @data.map do |answer|
      answer.join(' ')
    end
    strings_joined[0] = strings_joined[0].gsub("QUIZ ANSWERS ", '')
    @data = strings_joined
  end

  # Now we need to sort the answers in numeric order so the question
  # and answer orders match. Start by splitting each answer into two
  # so we have a string with the answer number and one with the answer
  # There should only be 25 answers so until there is that amount, remove
  # the last.
  # finally, convert numbers to integers to be sorted and string whitespace
  # from the answers.
  def sort_answers
    ans_arr = @data.map do |answer|
      answer.split(' ', 2)
    end
    until ans_arr.count <= 25
      ans_arr.pop
    end
    a_num_to_i = ans_arr.map do |answer|
      answer = [answer[0].to_i, answer[1].strip]
    end
    @data = a_num_to_i.sort
  end

  # This method combines the previous answer manipulation methods from
  # to finish
  def a_string_to_hash
    self.remove_characters
    self.correct_formatting
    self.answer_split
    self.answer_join
    self.sort_answers
    self.arr_to_hash
    return self.data
  end
end


# ans1 = "QUIZ ANSWERS\n\n1 Darwin.\n2. Paper (parchment or grease-proof; used to cover the surface of a stock,\nstew, sauce or soup to reduce evaporation).\n3 East River.\n4 Battle (invasion) of Normandy (launched on June 6, 1944, D-Day).\n5 Fashion.\n6 “Thrilla in Manila”.\n7 On an aircraft (attached to the outboard trailing edge of each wing,\nused to control a plane when rolling or banking).\n\n8 Sarah Snook.\n\n9 Wurundjeri.\n\n10 Lady Gaga.\n\n11 A Cavalier King Charles spaniel and a poodle.\n12 Broadcaster video-on-demand.\n\n13 Korean Air.\n\n14 Bob Hawke.\n15 Sea snail.\n\n16 Heights.\n17 Ten-pin bowling (three strikes in a row).\n18 Germany, Switzerland and Austria.\n19 Plimsoll line.\n20 Groove Armada.\n21 Snagglepuss (cartoon character created by Hanna-Barbera).\n22 Fruit. 23 The speed of light.\n24 Coronation.\n25 Canberra (ACT) and Griffith (NSW).\n\nGET IT? Halfback.\n\f"

# puts a_string_to_hash(ans1)