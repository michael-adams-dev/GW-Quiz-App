class String
  def numeric?
    Float(self) != nil rescue false
  end
end

def remove_characters(str)
  str = str.gsub(/\n/, ' ').gsub(/\f/, ' ').gsub(/\s+/, ' ')
  str.split(' ')
end

# Answer strings will sometimes be formatted with a full stop after
# the answer number. This needs to be removed for answers to be separated
def correct_formatting(ans_str)
  formatted = [] 
  ans_str.each_with_index do |str, index|
    if str.end_with?('.') && ans_str[index - 1].end_with?('.')
      formatted << str.chop
    else
      formatted << str
    end
  end
  formatted
end

# Now we need to segment the array into each distinct answer.
# Sub strings will be added to a new array (single_answer) until
# the substring ends with a full stop, which indicates that is
# the end of the answer.
# Single_answer is then added to arr_of_strings, then cleared 
# So it can start gathering the sub strings of the next answer.
def answer_split(split_strings)
  arr_of_strings = []
  single_answer = []
  split_strings.each do |str|
    if str[-1] == '.'
      single_answer << str
      arr_of_strings << single_answer
      single_answer = []
    else
      single_answer << str
    end
  end
  arr_of_strings << single_answer
  arr_of_strings
end

# Now we need to join the sub strings that form each answer
# so loop through the array to get each array of sub strings
# then join the sub stings together with a space
# finally, remove the quiz answers string from the start of 
# answer 1
def answer_join(arr)
  strings_joined = arr.map do |answer|
    answer.join(' ')
  end
  strings_joined[0] = strings_joined[0].gsub("QUIZ ANSWERS ", '')
  strings_joined
end

# Now we need to sort the answers in numeric order so the question
# and answer orders match. Start by splitting each answer into two
# so we have a string with the answer number and one with the answer
# There should only be 25 answers so until there is that amount, remove
# the last.
# finally, convert numbers to integers to be sorted and string whitespace
# from the answers.
def sort_answers(arr)
  ans_arr = arr.map do |answer|
    answer.split(' ', 2)
  end
  until ans_arr.count <= 25
    ans_arr.pop
  end
  a_num_to_i = ans_arr.map do |answer|
    answer = [answer[0].to_i, answer[1].strip]
  end
  return a_num_to_i.sort
end

# The last step is to turn the question or answer array into a hash
# The method creates a blank has and maps the array integers to the key
# and the array string (Q or A) to the value and returns the hash
def arr_to_hash(q_or_a_arr)
  questions_hash = {}
  q_or_a_arr.each do |q_or_a|
    questions_hash[q_or_a.first] = q_or_a.last
  end
  questions_hash
end

# This method combines the previous answer manipulation methods from
# to finish
def a_string_to_hash(str)
  step1 = remove_characters(str)
  step2 = correct_formatting(step1)
  step3 = answer_split(step2)
  step4 = answer_join(step3)
  step5 = sort_answers(step4)
  arr_to_hash(step5)
end

test = a_string_to_hash(ans2)

test.each do |number, question|
  puts "Question #{number} #{question}"
end
