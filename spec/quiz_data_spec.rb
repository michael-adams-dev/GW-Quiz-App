require_relative '../lib/quiz_data'

require 'rspec/autorun'

RSpec.describe QuizData do
  describe 'when a quiz data object looks for image urls' do
    it 'should return an array' do
      data = QuizData.new('https://www.picuki.com/media/2411315046220078073')
      urls = data.get_image_urls
      expect(urls.is_a?(Array)).to be true
    end

    it 'should return two elements' do
      data = QuizData.new('https://www.picuki.com/media/2411315046220078073')
      urls = data.get_image_urls
      expect(urls.length).to be 2
    end

    it 'should return the questions image url as a string' do
      data = QuizData.new('https://www.picuki.com/media/2411315046220078073')
      urls = data.get_image_urls
      expect(urls[0].is_a?(String)).to be true
    end

    it 'should return the answers image url as a string' do
      data = QuizData.new('https://www.picuki.com/media/2411315046220078073')
      urls = data.get_image_urls
      expect(urls[1].is_a?(String)).to be true
    end
  end
end