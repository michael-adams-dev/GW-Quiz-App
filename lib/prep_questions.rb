class String
  def numeric?
    Float(self) != nil rescue false
  end
end

# First remove all of the unnecessary characters from the string
def remove_characters(str)
  str = str.gsub(/\n/, ' ').gsub(/\f/, ' ').gsub(/\s+/, ' ')
  return str.split(' ')
end

# Next we need to segment the array into each distinct question
# This will be done by creating an array of strings for each question
# called single_question, sub strings are added until the end of q
# this array is then added to a larger array to hold them all
# The method will start a new array for each question once it finds a
# string with length 2 or 3 that starts with a number and ends with a 
# full stop, e.g. 2. or 16. 
def question_split(split_strings)
  arr_of_strings = []
  single_question = []
  split_strings.each do |str|
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
  arr_of_strings
end

# Now we need to join the sub strings that form each question
# so loop through the array to get each array of sub strings
# then join the sub stings together with a space
def question_join(arr)
  strings_joined = arr.map do |question|
    question.join(' ')
  end
  strings_joined
end

# Now we need to sort the questions in numeric order so the question
# and answer orders match. Start by splitting each question into two
# so we have a string with the question number and one with the question
# Then remove the first array which has the quiz intro but no question.
# finally, convert numbers to integers to be sorted and string whitespace
# from the questions.
def sort_questions(arr)
  q_arr = arr.map do |question|
    question.split('.', 2)
  end
  q_arr.shift
  q_num_to_i = q_arr.map do |question|
    question = [question[0].to_i, question[1].strip]
  end
  return q_num_to_i.sort
end

def arr_to_hash(q_or_a_arr)
  questions_hash = {}
  q_or_a_arr.each do |q_or_a|
    questions_hash[q_or_a.first] = q_or_a.last
  end
  questions_hash
end

# This method combines the previous question manipulation methods from
# to finish
def q_string_to_hash(str)
  step1 = remove_characters(str)
  step2 = question_split(step1)
  step3 = question_join(step2)
  step4 = sort_questions(step3)
  arr_to_hash(step4)
end

test = q_string_to_hash(str3)

test.each do |number, question|
  puts "Question #{number} #{question}"
end


