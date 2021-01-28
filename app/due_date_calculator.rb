require 'date'

class DueDateCalculator

  attr_reader :submitted_at, :turnaround_time, :start, :work_start, :work_end

  def initialize(options = {})
    @submitted_at    = options[:submitted_at] || DateTime.now
    @turnaround_time = options[:turnaround_time].to_i
    @work_start      = options[:work_start] || 9
    @work_end        = options[:work_end] || 17
    @start           = coerced_into_working_hours(datetime_from(submitted_at))
  end

  def execute
    # TODO
  end
  alias :run :execute

  private

  def datetime_from(input)
    input.is_a?(String) ? DateTime.strptime(input, '%Y-%M-%d') : input.to_datetime
  end

  def work_start_on(t)
    DateTime.new(t.year, t.month, t.day, work_start)
  end

  def work_end_on(t)
    DateTime.new(t.year, t.month, t.day, work_end)
  end

  def coerced_into_working_hours(input_datetime)
    if input_datetime > work_end_on(input_datetime)
      ret = input_datetime + 1
      ret = DateTime.new(ret.year, ret.month, ret.day, work_start)
    elsif input_datetime < work_start_on(input_datetime)
      ret = work_start_on(input_datetime)
    else
      ret = input_datetime
    end

    set_to_monday_if_weekend(ret)
  end

  def set_to_monday_if_weekend(input_datetime)
    case input_datetime.strftime('%A')
    when 'Saturday'
      input_datetime + 2
    when 'Sunday'
      input_datetime + 1
    else
      input_datetime
    end
  end
end
