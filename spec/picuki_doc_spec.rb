require_relative '../lib/picuki_doc'

require 'rspec/autorun'

RSpec.describe PicukiDoc do
  describe 'when a Picuki doc object looks for the selected url' do
    it 'should return a string' do
      new_page = PicukiDoc.new('https://www.picuki.com/profile/goodweekendquiz')
      url = new_page.get_selected_quiz_url(1)
      expect(url.is_a?(String)).to be true
    end

    it 'should get the url of the latest quiz' do 
      new_page = PicukiDoc.new('https://www.picuki.com/profile/goodweekendquiz')
      url = new_page.get_selected_quiz_url(1)
      expect(url).to eq 'https://www.picuki.com/media/2411315046220078073'
    end
  end
end