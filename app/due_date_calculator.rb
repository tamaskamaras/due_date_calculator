require 'date'

class DueDateCalculator

  attr_reader :submitted_at, :turnaround_time, :start, :work_start, :work_end

  def initialize(options = {})
    @submitted_at    = options[:submitted_at] || DateTime.now
    @turnaround_time = options[:turnaround_time].to_f
    @work_start      = options[:work_start] || 9
    @work_end        = options[:work_end] || 17
    @start           = coerced_into_working_hours(datetime_from(submitted_at))
  end

  def execute
    ret            = start.to_time
    remaining_time = hours(turnaround_time)

    while remaining_time > 0 do
      if remaining_time >= hours(8)
        ret += hours(24)
        remaining_time -= hours(8)
      else
        ret += nighttime if seconds_until_workday_end(ret) < remaining_time
        ret += remaining_time
        remaining_time = 0
      end
      ret = set_to_monday_if_weekend(ret)
    end

    ret.to_datetime
  end
  alias :run :execute

  private

  def hours(n)
    n * 3600
  end

  def days(n)
    n * hours(24)
  end

  def nighttime
    (24 - (work_end - work_start)) * 3600
  end

  def seconds_until_workday_end(basetime)
    work_end_on(basetime).to_time - basetime.to_time
  end

  def datetime_from(input)
    input.is_a?(String) ? DateTime.iso8601(input) : input.to_datetime
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

    set_to_monday_if_weekend(ret.to_time).to_datetime
  end

  def set_to_monday_if_weekend(input_datetime)
    case input_datetime.strftime('%A')
    when 'Saturday'
      input_datetime + days(2)
    when 'Sunday'
      input_datetime + days(1)
    else
      input_datetime
    end
  end
end
