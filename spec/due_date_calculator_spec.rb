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
      context 'when #submitted_at is before workstart' do
        it 'is set to #work_start (9 am) on the same day'
      end
      context 'when #submitted_at is after workstart' do
        it 'is set to #work_start (9 am) on the next day'
      end
      context 'when #submitted_at is on weekend' do
        it 'is set to #work_start (9 am) on next monday'
      end
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
