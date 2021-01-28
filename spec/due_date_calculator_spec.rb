require 'rspec'

RSpec.describe DueDateCalculator do
  describe '#submitted_at' do
    describe 'allows input format as' do
      context 'Date'
      context 'Time'
      context 'DateTime'
      context 'String'
    end

    describe 'is coerced into working hours' do
      context 'when input is before workstart'
      context 'when input is after workstart'
      context 'when input is on weekend'
    end
  end

  describe 'result' do
    context 'when turnaround_time is' do
      context '3 hours'
      context '16 hours'
      context '40 hours'
      context '80 hours'
    end
  end
end
