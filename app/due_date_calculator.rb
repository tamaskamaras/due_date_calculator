require 'date'

class DueDateCalculator

  attr_reader :submitted_at, :turnaround_time, :start

  def initialize(options = {})
    @submitted_at    = options[:submitted_at] || DateTime.now
    @turnaround_time = options[:turnaround_time].to_i
    @start           = datetime_from(submitted_at)
  end

  def execute
    # TODO
  end
  alias :run :execute

  private

  def datetime_from(input)
    input.is_a?(String) ? DateTime.strptime(input, '%Y-%M-%d') : input.to_datetime
  end
end
