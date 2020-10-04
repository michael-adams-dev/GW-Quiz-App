require_relative '../lib/quiz_initialiser'

require 'rspec/autorun'

q_image = 'https://scontent-lga3-1.cdninstagram.com/v/t51.2885-15/e35/p1080x1080/119652025_337780914133040_5800256762517549449_n.jpg?_nc_ht=scontent-lga3-1.cdninstagram.com&_nc_cat=108&_nc_ohc=UXeLnJbaGoYAX9DqXci&_nc_tp=19&oh=0522ca84c8707623f4f46fa255610cc5&oe=5FA470A0'

a_image = 'https://scontent-lga3-1.cdninstagram.com/v/t51.2885-15/e35/p1080x1080/119653121_809160603228578_6858281693343835845_n.jpg?_nc_ht=scontent-lga3-1.cdninstagram.com&_nc_cat=102&_nc_ohc=GqTBbs3qLjcAX9E-XQh&_nc_tp=19&oh=d26b4aea24f092aae98472626718c67f&oe=5FA35825'

RSpec.describe QuizInitialiser do
  describe 'when a QuizInitialiser object runs images to strings' do
    it 'should update its questions attribute to be a string' do
      quiz_init = QuizInitialiser.new(["./questions.jpg", "./answers.jpg"])
      QuizInitialiser.download_images([q_image, a_image])
      quiz_init.images_to_strings
      expect(quiz_init.questions.is_a?(String)).to be true
    end

    it 'should have an attribute with the same first letter as the answers image text' do
      quiz_init = QuizInitialiser.new(["./questions.jpg", "./answers.jpg"])
      QuizInitialiser.download_images([q_image, a_image])
      quiz_init.images_to_strings
      expect(quiz_init.answers[0]).to eq 'Q'
    end
  end
end