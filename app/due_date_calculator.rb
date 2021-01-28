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
    ret             = start
    remaining_hours = turnaround_time

    while remaining_hours > 0 do
      if remaining_hours >= 8
        ret += 1
        remaining_hours -= 8
      else
        secs = seconds_until_workday_end(ret)
        if secs < 0 # the remaining time overlaps the end of the workday
          add_nighttime_ours_to(ret)

          ret = ret.to_time
          ret += (remaining_hours * 3600)
        else
          ret = ret.to_time + (remaining_hours * 3600)
          ret = ret.to_datetime
          ret = ret.to_datetime
          remaining_hours = 0
        end
      end

      ret = set_to_monday_if_weekend(ret)
    end

    ret
  end
  alias :run :execute

  private

  def seconds_until_workday_end(basetime)
    work_end_on(basetime).to_time - basetime.to_time
  end

  def add_nighttime_ours_to(basetime)
    # TODO
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
