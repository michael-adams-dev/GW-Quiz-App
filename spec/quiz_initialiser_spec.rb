require_relative '../lib/quiz_initialiser'

require 'rspec/autorun'

RSpec.describe QuizInitialiser do
  describe 'when a QuizInitialiser object runs images to strings' do
    it 'should update its questions attribute to be a string' do
      quiz_init = QuizInitialiser.new(["../public/imgs/questions.jpg", "../public/imgs/answers.jpg"])
      quiz_init.images_to_strings
      expect(quiz_init.questions.is_a?(String)).to be true
    end

    it 'should have an attribute with the same first letter as the answers image text' do
      quiz_init = QuizInitialiser.new(["../public/imgs/questions.jpg", "../public/imgs/answers.jpg"])
      quiz_init.images_to_strings
      expect(quiz_init.answers[0]).to eq 'Q'
    end
  end
end