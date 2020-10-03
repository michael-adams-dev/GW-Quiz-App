require_relative '../lib/prepare_quiz'

require 'rspec/autorun'

q_string = "THE QUIZ\n\nCOMPILED BY Facqui Martinez & Stephanie Bull\n\n \n\n1. Palmerston was the\nformer name of which\nAustralian city?\n\n2. What is a cartouche, used\nin French cooking, made from?\n\n3. New York City’s\nQueensboro Bridge crosses\nwhich river?\n\n4. Operation Overlord\nwas the codename for\nwhich battle during\nWorld War II?\n\n5. Australia’s Indigenous\nNIFA awards celebrate\nexcellence in what industry?\n\n6. What tagline was given to\nthe boxing match between Joe\nFrazier and Muhammad Ali in\nManila in 1975?\n\n7. Where would you\nfind an aileron?\n\n8. Which Australian actress\nplays Shiv Roy in the TV series\nSuccession?\n\n9. Who are the traditional\nowners of greater\nMelbourne: Wurundjeri,\nGadigal or Larrakia?\n\n10. Which artist won the inaugural\n\nTricon award at the 2020 MTV\nVideo Music Awards?\n\n18. Which three\nEuropean countries\nshare Lake Constance?\n\n19. Starting with “P”,\nwhat name is given to\nthe load limit line on\na ship’s hull?\n\n \n\n11. A cavoodle is a cross between\nwhich two dog breeds?\n\n12. What does the initialism\n\n“BVOD\" stand for?\n\n13. The logo of which\ninternational airline is based\non the yin and yang symbol?\n\n14. “The Silver Bodgie”\nwas a nickname for which\nformer Australian PM?\n\n15. What is another name for\n\na whelk?\n\n16. What is acrophobia the\n\nfear of?\n\n17. In which sport can you\n\nbowl a turkey?\n\n20. Edge of the Horizon\nis which electronic band's\nfirst album in 10 years?\n\n21. Which pink\nanthropomorphic\nmountain lion aspired\nto be a stage actor?\n\n22. Is an olive a fruit,\na vegetable or a nut?\n\n23. What does “c” represent\nin the equation E = mc2?\n\n24. What is the name of artist Ai\nWeiwei's 2020 coronavirus film?\n\n25. Walter Burley and\nMarion Mahony Griffin\nhelped design which\ntwo Australian cities?\n\f"

a_string = "QUIZ ANSWERS\n\n1 Darwin.\n2. Paper (parchment or grease-proof; used to cover the surface of a stock,\nstew, sauce or soup to reduce evaporation).\n3 East River.\n4 Battle (invasion) of Normandy (launched on June 6, 1944, D-Day).\n5 Fashion.\n6 “Thrilla in Manila”.\n7 On an aircraft (attached to the outboard trailing edge of each wing,\nused to control a plane when rolling or banking).\n\n8 Sarah Snook.\n\n9 Wurundjeri.\n\n10 Lady Gaga.\n\n11 A Cavalier King Charles spaniel and a poodle.\n12 Broadcaster video-on-demand.\n\n13 Korean Air.\n\n14 Bob Hawke.\n15 Sea snail.\n\n16 Heights.\n17 Ten-pin bowling (three strikes in a row).\n18 Germany, Switzerland and Austria.\n19 Plimsoll line.\n20 Groove Armada.\n21 Snagglepuss (cartoon character created by Hanna-Barbera).\n22 Fruit. 23 The speed of light.\n24 Coronation.\n25 Canberra (ACT) and Griffith (NSW).\n\nGET IT? Halfback.\n\f"


RSpec.describe PrepQuizItems do
  describe 'when the quiz data is converted to a hash' do
    it 'should have a hash object stored in data attribute' do
      questions = PrepQuizItems.new(q_string)
      q_hash = questions.q_string_to_hash
      expect(q_hash.is_a?(Hash)).to be true
    end

    it 'should have have 25 questions in the questions hash object' do
      questions = PrepQuizItems.new(q_string)
      q_hash = questions.q_string_to_hash
      expect(q_hash.length).to be 25
    end

    it 'should have have 25 answers in the answer hash object' do
      questions = PrepQuizItems.new(a_string)
      a_hash = questions.a_string_to_hash
      expect(a_hash.length).to be 25
    end
  end
end
