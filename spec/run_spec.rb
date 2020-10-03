require_relative '../lib/run'

require 'rspec/autorun'

RSpec.describe RunApp do
  describe 'when images are converted to hashes' do
    it 'it should return two objects in an array' do
      arr = RunApp.convert_quiz_strings_to_hashes(1)
      expect(arr.length).to be 2
    end
  end
end