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
      RSpec.shared_examples 'coerce #submitted_at into Time as #start' do
        it 'returns Time' do
          expect(subject.start).to be_a(Time)
        end
      end

      context 'Date' do
        let(:submitted_at) { Date.today }

        include_examples 'coerce #submitted_at into Time as #start'
      end

      context 'Time' do
        let(:submitted_at) { Time.now }

        include_examples 'coerce #submitted_at into Time as #start'
      end

      context 'DateTime' do
        let(:submitted_at) { DateTime.now }

        include_examples 'coerce #submitted_at into Time as #start'
      end

      context 'String' do
        let(:submitted_at) { '2021-01-28' }

        include_examples 'coerce #submitted_at into Time as #start'
      end
    end

    describe 'is coerced into working hours' do
      context 'when #submitted_at is before workstart' do
        let(:submitted_at) { Time.new(2021, 1, 28, 5, 23, 15) }

        it 'is set to #work_start (9 am) on the same day' do
          expect(subject.start).to eq(Time.new(2021, 1, 28, 9, 0, 0))
        end
      end

      context 'when #submitted_at is after workstart' do
        let(:submitted_at) { Time.new(2021, 1, 28, 18, 21, 18) }

        it 'is set to #work_start (9 am) on the next day' do
          expect(subject.start).to eq(Time.new(2021, 1, 29, 9, 0, 0))
        end
      end

      context 'when #submitted_at is on weekend' do
        let(:submitted_at) { Time.new(2021, 1, 30, 5, 23, 15) }

        it 'is set to #work_start (9 am) on next monday' do
          expect(submitted_at.saturday?).to be(true)
          expect(subject.start).to eq(Time.new(2021, 2, 1, 9, 0, 0))
        end
      end
    end
  end

  describe 'result' do
    let(:submitted_at) { Time.new(2021, 1, 28, 10, 23, 15) }

    context 'when turnaround_time is' do
      context '3 hours' do
        let(:turnaround_time) { 3 }

        it 'returns the same date and time at 3 hours later' do
          expect(subject.run).to eq(Time.new(2021, 1, 28, 13, 23, 15))
        end
      end

      context '7 hours (thus overlaps the end of the workday)' do
        let(:turnaround_time) { 7 }

        it 'returns the next working day at 1 hours later' do
          expect(subject.run).to eq(Time.new(2021, 1, 29, 9, 23, 15))
        end
      end

      context '16 hours' do
        let(:turnaround_time) { 16 }

        it 'returns the same time 2 working days later' do
          expect(subject.run).to eq(Time.new(2021, 2, 1, 10, 23, 15))
        end
      end

      context '40 hours' do
        let(:turnaround_time) { 40 }

        it 'returns the same time 1 week later' do
          expect(subject.run).to eq(Time.new(2021, 2, 4, 10, 23, 15))
        end
      end

      context '80 hours' do
        let(:turnaround_time) { 80 }

        it 'returns the same time 2 weeks later' do
          expect(subject.run).to eq(Time.new(2021, 2, 11, 10, 23, 15))
        end
      end

      context 'when #submitted_at is after workstart and turnaround_time is 8' do
        let(:submitted_at)    { Time.new(2021, 1, 28, 18, 21, 18) }
        let(:turnaround_time) { 8 }

        it 'retruns the end of next working day' do
          expect(subject.run).to eq(Time.new(2021, 1, 29, 17, 0, 0))
        end
      end
    end
  end
end
