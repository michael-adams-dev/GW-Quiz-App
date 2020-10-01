ans1 = "QUIZ ANSWERS\n\n1 Darwin.\n2. Paper (parchment or grease-proof; used to cover the surface of a stock,\nstew, sauce or soup to reduce evaporation).\n3 East River.\n4 Battle (invasion) of Normandy (launched on June 6, 1944, D-Day).\n5 Fashion.\n6 “Thrilla in Manila”.\n7 On an aircraft (attached to the outboard trailing edge of each wing,\nused to control a plane when rolling or banking).\n\n8 Sarah Snook.\n\n9 Wurundjeri.\n\n10 Lady Gaga.\n\n11 A Cavalier King Charles spaniel and a poodle.\n12 Broadcaster video-on-demand.\n\n13 Korean Air.\n\n14 Bob Hawke.\n15 Sea snail.\n\n16 Heights.\n17 Ten-pin bowling (three strikes in a row).\n18 Germany, Switzerland and Austria.\n19 Plimsoll line.\n20 Groove Armada.\n21 Snagglepuss (cartoon character created by Hanna-Barbera).\n22 Fruit. 23 The speed of light.\n24 Coronation.\n25 Canberra (ACT) and Griffith (NSW).\n\nGET IT? Halfback.\n\f"


ans2 = "QUIZ ANSWERS\n\n1 Women's wheelchair basketball.\n2 5 per cent (7.692 million sq km).\n3 Argentina (derived from the Latin argentum, meaning silver).\n4 Elizabeth Debicki.\n5 The Birthday Party.\n6 European rivers.\n7 String (the bow frog is the end part of a stringed musical instrument's bow).\n8 Russell Crowe.\n9 Dawn.\n10 High-definition multimedia interface.\n11 Lieutenant Colonel Bill Kilgore (played by Robert Duvall) in Apocalypse Now.\n12 Lonely Street.\n13 125 (5x5x5).\n14 Azerbaijan.\n15 Jurassic (201 million to 145 million years ago).\n16 Bayern Munich (defeating Paris Saint-Germain 1-0).\n17 Ontology.\n18 Three (NSW, SA and NT).\n19 Mrs Beeton (Isabella Beeton).\n20 Hannah Gadsby.\n21 Sichuan province.\n22 Seven.\n23 Fencing.\n24 Whitechapel (in London's East End).\n25 Dame Mary Gilmore\n(featured on the $10 note) was Scott Morrison’s great-great aunt.\n\nGET IT? Listen.\n\f"


ans3 = "QUIZ ANSWERS\n\n1 $US1 million.\n2 Aleister Crowley (1875-1947).\n3 Dodecagonal (12-sided).\n4 Triple point.\n5 Medal of the Order.\n6A foot.\n7 The 1st Academy Awards ceremony.\n\n8 The stomach.\n9 The Yield.\n\n10 The Mediterranean and the Red seas.\n11 Sabre-toothed tiger or sabre-toothed cat.\n12 The Netherlands.\n\n13 Peru and Brazil.\n\n14 /'m a Believer (composed by Neil Diamond, first recorded by The Monkees in 1966).\n15 Sternum.\n\n16 Lion (red).\n\n17 Boxer Muhammad Ali.\n\n18 Arrabbiata.\n\n19 Australia.\n\n20 Pitch Perfect.\n\n21 String.\n\n22 Game of Thrones.\n\n23 Sound.\n\n24 United Arab Emirates.\n\n25 Campanologist (bell ringer).\n\nGET IT? Monochrome.\n\f"

class String
  def numeric?
    Float(self) != nil rescue false
  end
end

def remove_characters(str)
  str = str.gsub(/\n/, ' ').gsub(/\f/, ' ').gsub(/\s+/, ' ')
  str.split(' ')
end

def correct_formatting(ans_str)
  formatted = [] 
  ans_str.each_with_index do | str, index |
    if str.end_with?('.') && ans_str[index - 1].end_with?('.')
      formatted << str.chop
    else
      formatted << str
    end
  end
  formatted
end

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

def question_join(arr)
  strings_joined = arr.map do |question|
    question.join(' ')
  end
  strings_joined[0] = strings_joined[0].gsub("QUIZ ANSWERS ", '')
  strings_joined
end

def sort_answers(arr)
  ans_arr = arr.map do |question|
    question.split(' ', 2)
  end
  until ans_arr.count <= 25
    ans_arr.pop
  end
  q_num_to_i = ans_arr.map do |question|
    question = [question[0].to_i, question[1].strip]
  end
  return q_num_to_i.sort
end

def arr_to_hash(questions_arr)
  questions_hash = {}
  questions_arr.each do |question|
    questions_hash[question.first] = question.last
  end
  questions_hash
end

def a_string_to_hash(ans1)
  test1 = remove_characters(ans1)
  test2 = correct_formatting(test1)
  test3 = answer_split(test2)
  test4 = question_join(test3)
  test5 = sort_answers(test4)
  arr_to_hash(test5)
end

test = a_string_to_hash(ans2)

test.each do |number, question|
  puts "Question #{number} #{question}"
end
