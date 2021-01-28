require 'date'

class DueDateCalculator

  attr_reader :submitted_at, :turnaround_time, :start, :work_start, :work_end

  def initialize(options = {})
    @submitted_at    = options[:submitted_at] || DateTime.now
    @turnaround_time = options[:turnaround_time].to_i
    @start           = coerced_into_working_hours(datetime_from(submitted_at))
    @work_start      = options[:work_start] || 9
    @work_end        = options[:work_end] || 17
  end

  def execute
    # TODO
  end
  alias :run :execute

  private

  def datetime_from(input)
    input.is_a?(String) ? DateTime.strptime(input, '%Y-%M-%d') : input.to_datetime
  end

  def coerced_into_working_hours(input_datetime)
    # TODO
    input_datetime
  end
end
