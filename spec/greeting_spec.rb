require_relative '../lib/greeting'

require 'rspec/autorun'

RSpec.describe Greeting do
  describe 'when a greeting object is created' do
    it 'should be have as many facts as constant FACTS' do
      greet = Greeting.new
      expect(greet.facts.length).to be 2
    end

    it 'should have the same facts as constant FACTS' do
      greet = Greeting.new
      expect(greet.facts).to eq ["The sky is blue", "It's Spring at the moment"]
    end
  end
end