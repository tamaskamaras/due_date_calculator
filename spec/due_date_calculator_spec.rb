require 'rspec'
require './app/due_date_calculator'

RSpec.describe DueDateCalculator do
  subject do
    described_class.new(
      submitted_at: submitted_at,
      turnaround_time: turnaround_time
    )
  end

  describe '#start' do
    let(:turnaround_time) { 16 }

    describe 'allows input format as' do
      RSpec.shared_examples 'coerce #submitted_at into DateTime as #start' do
        it 'returns DateTime' do
          expect(subject.start).to be_a(DateTime)
        end
      end

      context 'Date' do
        let(:submitted_at) { Date.today }

        include_examples 'coerce #submitted_at into DateTime as #start'
      end

      context 'Time' do
        let(:submitted_at) { Time.now }

        include_examples 'coerce #submitted_at into DateTime as #start'
      end

      context 'DateTime' do
        let(:submitted_at) { DateTime.now }

        include_examples 'coerce #submitted_at into DateTime as #start'
      end

      context 'String' do
        let(:submitted_at) { '2021-01-28' }

        include_examples 'coerce #submitted_at into DateTime as #start'
      end
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

  describe '.run'
end
